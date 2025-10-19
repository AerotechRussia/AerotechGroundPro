package com.aerotechrussia.agp;

import com.aerotechrussia.agp.AGPUsbId;

import com.hoho.android.usbserial.driver.ProbeTable;
import com.hoho.android.usbserial.driver.UsbSerialProber;

public class AGPProber
{
    public static UsbSerialProber getQGCProber() {
        return new UsbSerialProber(getQGCProbeTable());
    }

    public static ProbeTable getQGCProbeTable() {
        final ProbeTable probeTable = new ProbeTable();

        return probeTable;
    }
}
