package controller;

import com.google.common.collect.Iterators;
import com.google.gcloud.AuthCredentials;
import com.google.gcloud.dns.ChangeRequest;
import com.google.gcloud.dns.ChangeRequestInfo;
import com.google.gcloud.dns.Dns;
import com.google.gcloud.dns.DnsOptions;
import com.google.gcloud.dns.RecordSet;
import com.google.gcloud.dns.Zone;
import com.google.gcloud.dns.ZoneInfo;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Iterator;

/**
 * Created by derka on 4/12/16.
 */
public class Controller {

  private static Dns dns;

  private static Dns dns() {
    if (dns == null) {
      try {
        dns = DnsOptions.builder().authCredentials(AuthCredentials.createForJson(
            new FileInputStream("ozarov-javamrsample-d31df970a3cf.json")))
            .projectId("ozarov-javamrsample")
            .build()
            .service();
      } catch (IOException ex) {
        throw new RuntimeException(ex);
      }
    }
    return dns;
  }

  public static Zone[] getZones() {
    Iterator<Zone> zoneIterator = dns().listZones().iterateAll();
    return Iterators.toArray(zoneIterator, Zone.class);
  }

  public static String sayHello() {
    return "hello";
  }

  public static Zone getZone(String zoneName) {
    return dns().getZone(zoneName);
  }

  public static RecordSet[] getRecords(String zoneName) {
    return Iterators.toArray(dns().listRecordSets(zoneName).iterateAll(), RecordSet.class);
  }

  public static ChangeRequest[] getChanges(String zoneName) {
    return Iterators.toArray(dns().listChangeRequests(zoneName).iterateAll(), ChangeRequest.class);
  }

  public static void deleteRecord(String zoneName, String recordName, String type) {
    RecordSet[] records = getRecords(zoneName);
    for (RecordSet record : records) {
      if (record.name().equals(recordName) && record.type() == RecordSet.Type.valueOf(type)) {
        dns().applyChangeRequest(zoneName, ChangeRequest.builder().delete(record).build());
        return;
      }
    }
  }

  public static void deleteZone(String zoneName) {
    RecordSet[] records = getRecords(zoneName);
    ChangeRequestInfo.Builder builder = ChangeRequest.builder();
    for (RecordSet record : records) {
      if (record.type() != RecordSet.Type.NS && record.type() != RecordSet.Type.SOA) {
        builder.delete(record);
      }
    }
    ChangeRequestInfo change = builder.build();
    if (!change.deletions().isEmpty()) {
      ChangeRequest changeRequest = dns().applyChangeRequest(zoneName, change);
      while (changeRequest.status() != ChangeRequestInfo.Status.DONE) {
        try {
          Thread.sleep(500);
        } catch (InterruptedException e) {
          e.printStackTrace();
        }
        changeRequest = dns().getChangeRequest(zoneName, changeRequest.generatedId());
      }
    }
    dns().delete(zoneName);
  }

  public static void addZone(String name, String domain, String description) {
    ZoneInfo zone = dns().create(ZoneInfo.of(name, domain, description));
  }

  public static void addRecord(String zoneName, RecordSet recordSet) {
    dns().applyChangeRequest(zoneName, ChangeRequest.builder().add(recordSet).build());
  }
}
