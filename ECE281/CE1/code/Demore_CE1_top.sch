<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_2" />
        <signal name="XLXN_3" />
        <signal name="XLXN_5" />
        <signal name="led0" />
        <signal name="sw7" />
        <signal name="sw5" />
        <signal name="sw6" />
        <signal name="XLXN_11" />
        <signal name="XLXN_12" />
        <signal name="XLXN_13" />
        <signal name="XLXN_14" />
        <signal name="XLXN_16" />
        <signal name="XLXN_18" />
        <signal name="XLXN_20" />
        <signal name="XLXN_22" />
        <signal name="XLXN_23" />
        <port polarity="Output" name="led0" />
        <port polarity="Input" name="sw7" />
        <port polarity="Input" name="sw5" />
        <port polarity="Input" name="sw6" />
        <blockdef name="and2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <arc ex="144" ey="-144" sx="144" sy="-48" r="48" cx="144" cy="-96" />
            <line x2="64" y1="-48" y2="-48" x1="144" />
            <line x2="144" y1="-144" y2="-144" x1="64" />
            <line x2="64" y1="-48" y2="-144" x1="64" />
        </blockdef>
        <blockdef name="inv">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="160" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="64" y1="0" y2="-64" x1="64" />
            <circle r="16" cx="144" cy="-32" />
        </blockdef>
        <blockdef name="or2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <arc ex="192" ey="-96" sx="112" sy="-48" r="88" cx="116" cy="-136" />
            <arc ex="48" ey="-144" sx="48" sy="-48" r="56" cx="16" cy="-96" />
            <line x2="48" y1="-144" y2="-144" x1="112" />
            <arc ex="112" ey="-144" sx="192" sy="-96" r="88" cx="116" cy="-56" />
            <line x2="48" y1="-48" y2="-48" x1="112" />
        </blockdef>
        <block symbolname="and2" name="XLXI_1">
            <blockpin signalname="sw7" name="I0" />
            <blockpin signalname="XLXN_2" name="I1" />
            <blockpin signalname="XLXN_3" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_2">
            <blockpin signalname="sw5" name="I0" />
            <blockpin signalname="sw6" name="I1" />
            <blockpin signalname="XLXN_5" name="O" />
        </block>
        <block symbolname="inv" name="XLXI_3">
            <blockpin signalname="sw6" name="I" />
            <blockpin signalname="XLXN_2" name="O" />
        </block>
        <block symbolname="or2" name="XLXI_4">
            <blockpin signalname="XLXN_5" name="I0" />
            <blockpin signalname="XLXN_3" name="I1" />
            <blockpin signalname="led0" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <branch name="led0">
            <wire x2="2288" y1="1072" y2="1072" x1="2272" />
            <wire x2="2304" y1="1072" y2="1072" x1="2288" />
        </branch>
        <branch name="sw7">
            <wire x2="1680" y1="976" y2="976" x1="1568" />
        </branch>
        <branch name="sw5">
            <wire x2="1552" y1="1168" y2="1168" x1="1040" />
        </branch>
        <branch name="sw6">
            <wire x2="1312" y1="1104" y2="1104" x1="1056" />
            <wire x2="1552" y1="1104" y2="1104" x1="1312" />
            <wire x2="1168" y1="912" y2="912" x1="1088" />
            <wire x2="1088" y1="912" y2="1024" x1="1088" />
            <wire x2="1312" y1="1024" y2="1024" x1="1088" />
            <wire x2="1312" y1="1024" y2="1104" x1="1312" />
        </branch>
        <instance x="1552" y="1232" name="XLXI_2" orien="R0" />
        <iomarker fontsize="28" x="1040" y="1168" name="sw5" orien="R180" />
        <iomarker fontsize="28" x="1056" y="1104" name="sw6" orien="R180" />
        <instance x="1680" y="1040" name="XLXI_1" orien="R0" />
        <branch name="XLXN_2">
            <wire x2="1680" y1="912" y2="912" x1="1392" />
        </branch>
        <iomarker fontsize="28" x="1568" y="976" name="sw7" orien="R180" />
        <instance x="1168" y="944" name="XLXI_3" orien="R0" />
        <instance x="2016" y="1168" name="XLXI_4" orien="R0" />
        <branch name="XLXN_3">
            <wire x2="1952" y1="944" y2="944" x1="1936" />
            <wire x2="1952" y1="944" y2="1040" x1="1952" />
            <wire x2="2016" y1="1040" y2="1040" x1="1952" />
        </branch>
        <branch name="XLXN_5">
            <wire x2="1824" y1="1136" y2="1136" x1="1808" />
            <wire x2="2016" y1="1104" y2="1104" x1="1824" />
            <wire x2="1824" y1="1104" y2="1136" x1="1824" />
        </branch>
        <iomarker fontsize="28" x="2304" y="1072" name="led0" orien="R0" />
        <text style="fontsize:32;fontname:Arial" x="1040" y="832">Demore CE1</text>
    </sheet>
</drawing>