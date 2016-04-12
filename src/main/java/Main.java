import com.google.gcloud.AuthCredentials;
import com.google.gcloud.dns.Dns;
import com.google.gcloud.dns.DnsOptions;
import com.google.gcloud.dns.Zone;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Iterator;

/**
 * Created by derka on 4/12/16.
 */
public class Main {

  public static void main(String... args) {
    Dns dns = null;
    try {
      dns = DnsOptions.builder().authCredentials(AuthCredentials.createForJson(
          new FileInputStream("/usr/local/google/home/derka/Downloads/ozarov-javamrsample-d31df970a3cf.json")))
          .build()
          .service();

      Iterator<Zone> zoneIterator = dns.listZones().iterateAll();
      while (zoneIterator.hasNext()) {
        Zone zone = zoneIterator.next();
        System.err.println(zone.name());
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
}
