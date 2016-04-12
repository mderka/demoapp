package controller;

import com.google.common.collect.Iterators;
import com.google.gcloud.AuthCredentials;
import com.google.gcloud.dns.ChangeRequest;
import com.google.gcloud.dns.Dns;
import com.google.gcloud.dns.DnsOptions;
import com.google.gcloud.dns.RecordSet;
import com.google.gcloud.dns.Zone;

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
    for(RecordSet record : records) {
      if(record.name().equals(recordName) && record.type() == RecordSet.Type.valueOf(type)) {
        dns().applyChangeRequest(zoneName, ChangeRequest.builder().delete(record).build());
        return;
      }
    }
  }
}
