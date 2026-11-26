function rocket = mjollnir_mass_mapping(rocket, declare_dependencies)
if ~declare_dependencies
    return
end


mapping = [
    % Thrust chamber
    component("AB01Thrustchamber.BBF02Precombustionchambercover", 0.441737)
    component("AB01Thrustchamber.BBC00MFuelgrainwithcylindricalinitialport002.BBC00MFuelgrainwithcylindricalinitialport", 0) % Fuel grain
    component("AB01Thrustchamber.AB04NozzleandPCC.BBK03PCCinletgraphiteinsert", 0.372)
    component("AB01Thrustchamber.AB04NozzleandPCC.BBK04PCCLid", 1.493475)
    component("AB01Thrustchamber.AB04NozzleandPCC.BBK05Nozzle", 1.696256)
    component("AB01Thrustchamber.AB04NozzleandPCC.BBK06NozzleHolder", 1.494064)
    component("AB01Thrustchamber.AB04NozzleandPCC.BBK08FuelGrainAxialClamp", 0.264272)
    component("AB01Thrustchamber.AB04NozzleandPCC.IBO002x13016", 0)
    component("AB01Thrustchamber.AB04NozzleandPCC.IBO01275x1387", 0)
    component("AB01Thrustchamber.AB04NozzleandPCC.IBO01275x138008", 0)
    component("AB02Kastrullen.AB05InjectorV2.BBA05InjectorCasingV2", 0.874649)
    

    % 8 x M6 hex 25mm InUes screw
    component("AB02Kastrullen.AB05InjectorV2.IBB01M6Hex25mmInUes", 0.007483)
    component("AB02Kastrullen.AB05InjectorV2.IBB01M6Hex25mmInUes001", 0.007483)
    component("AB02Kastrullen.AB05InjectorV2.IBB01M6Hex25mmInUes002", 0.007483)
    component("AB02Kastrullen.AB05InjectorV2.IBB01M6Hex25mmInUes003", 0.007483)
    component("AB02Kastrullen.AB05InjectorV2.IBB01M6Hex25mmInUes004", 0.007483)
    component("AB02Kastrullen.AB05InjectorV2.IBB01M6Hex25mmInUes005", 0.007483)
    component("AB02Kastrullen.AB05InjectorV2.IBB01M6Hex25mmInUes006", 0.007483)
    component("AB02Kastrullen.AB05InjectorV2.IBB01M6Hex25mmInUes007", 0.007483)

    component("AB02Kastrullen.AB05InjectorV2.IBC00M304100000601KPGpressuretransducer003", 0.098217)
    component("AB02Kastrullen.AB05InjectorV2.IBC00M304100000601KPGpressuretransducer007", 0.098217)

    % 8 x M6 hex 22mm InUes screw
    component("AB02Kastrullen.AB05InjectorV2.IBB05M6HEx22mmInUes", 0.006945)
    component("AB02Kastrullen.AB05InjectorV2.IBB05M6HEx22mmInUes001", 0.006945)
    component("AB02Kastrullen.AB05InjectorV2.IBB05M6HEx22mmInUes002", 0.006945)
    component("AB02Kastrullen.AB05InjectorV2.IBB05M6HEx22mmInUes003", 0.006945)
    component("AB02Kastrullen.AB05InjectorV2.IBB05M6HEx22mmInUes004", 0.006945)
    component("AB02Kastrullen.AB05InjectorV2.IBB05M6HEx22mmInUes005", 0.006945)
    component("AB02Kastrullen.AB05InjectorV2.IBB05M6HEx22mmInUes006", 0.006945)
    component("AB02Kastrullen.AB05InjectorV2.IBB05M6HEx22mmInUes007", 0.006945)
    component("AB02Kastrullen.AB05InjectorV2.BBA06InjectorPlateV2", 0.286488)
    component("AB02Kastrullen.AB05InjectorV2.IBC06M8x40AESIRtemperaturesensor", 0.02257)
    component("AB02Kastrullen.AB05InjectorV2.BBE21M8maletoM5femaleadapter", 0.005408)
    component("AB02Kastrullen.AB05InjectorV2.IBD07M54mm90Injector001", 0.012561)
    component("AB01Thrustchamber.BBF00Combustionchambercasing002", 3.55)

    % M6x14 countersunk screw
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind001", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind002", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind003", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind004", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind005", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind006", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind007", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind008", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind009", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind010", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind011", 0.003527)

    % 12 x M8x35 Socket cap screw
    component("AB01Thrustchamber.IBS16M8x35SocketCap", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap001", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap002", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap003", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap004", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap005", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap006", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap007", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap008", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap009", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap010", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap011", 0.021343)



    % Kastrullen
    
    % 4 x Thrust strut
    component("AB02Kastrullen.BBE00Thruststrut", 0.143647)
    component("AB02Kastrullen.BBE00Thruststrut001", 0.143647)
    component("AB02Kastrullen.BBE00Thruststrut002", 0.143647)
    component("AB02Kastrullen.BBE00Thruststrut003", 0.143647)

    % 8 x M4x16 torx screw
    component("AB02Kastrullen.AB08ValveAllwaysOpen.IBS05torxM4x16", 0.002266)
    component("AB02Kastrullen.AB08ValveAllwaysOpen.IBS05torxM4x017", 0.002266)
    component("AB02Kastrullen.IBS05torxM4x018", 0.002266)
    component("AB02Kastrullen.IBS05torxM4x019", 0.002266)
    component("AB02Kastrullen.IBS05torxM4x020", 0.002266)
    component("AB02Kastrullen.IBS05torxM4x021", 0.002266)
    component("AB02Kastrullen.IBS05torxM4x022", 0.002266)
    component("AB02Kastrullen.IBS05torxM4x023", 0.002266)


    % 8 x M4x12 screw missing

    % 10 M4x16 torx screws
    component("AB02Kastrullen.IBS05torxM4x024", 0.002266)
    component("AB02Kastrullen.IBS05torxM4x025", 0.002266)
    component("AB02Kastrullen.IBS05torxM4x026", 0.002266)
    component("AB02Kastrullen.IBS05torxM4x027", 0.002266)
    component("AB02Kastrullen.IBS05torxM4x028", 0.002266)
    component("AB02Kastrullen.IBS05torxM4x029", 0.002266)
    component("AB02Kastrullen.IBS05torxM4x030", 0.002266)
    component("AB02Kastrullen.IBS05torxM4x031", 0.002266)
    component("AB02Kastrullen.IBS05torxM4x032", 0.002266)
    component("AB02Kastrullen.IBS05torxM4x033", 0.002266)

    % 8 x M4 locknut
    component("AB02Kastrullen.AB07MainValve.IBN00M4locknut", 0.001216)
    component("AB02Kastrullen.AB07MainValve.IBN00M4locknut001", 0.001216)
    component("AB02Kastrullen.AB07MainValve.IBN00M4locknut002", 0.001216)
    component("AB02Kastrullen.AB07MainValve.IBN00M4locknut003", 0.001216)
    component("AB02Kastrullen.AB07MainValve.IBN00M4locknut004", 0.001216)
    component("AB02Kastrullen.AB07MainValve.IBN00M4locknut005", 0.001216)
    component("AB02Kastrullen.AB07MainValve.IBN00M4locknut006", 0.001216)
    component("AB02Kastrullen.AB07MainValve.IBN00M4locknut007", 0.001216)
    % 8 missing

    % 26 x M4 nuts
    component("AB02Kastrullen.AB08ValveAllwaysOpen.IBN01M4nut", 0.000817)
    component("AB02Kastrullen.AB08ValveAllwaysOpen.IBN01M4nut001", 0.000817)
    component("AB02Kastrullen.IBN01M4nut002", 0.000817)
    component("AB02Kastrullen.IBN01M4nut003", 0.000817)
    component("AB02Kastrullen.IBN01M4nut004", 0.000817)
    component("AB02Kastrullen.IBN01M4nut005", 0.000817)
    component("AB02Kastrullen.IBN01M4nut006", 0.000817)
    component("AB02Kastrullen.IBN01M4nut007", 0.000817)
    component("AB02Kastrullen.IBN01M4nut008", 0.000817)
    component("AB02Kastrullen.IBN01M4nut009", 0.000817)
    component("AB02Kastrullen.IBN01M4nut010", 0.000817)
    component("AB02Kastrullen.IBN01M4nut011", 0.000817)
    component("AB02Kastrullen.IBN01M4nut012", 0.000817)
    component("AB02Kastrullen.IBN01M4nut013", 0.000817)
    component("AB02Kastrullen.IBN01M4nut014", 0.000817)
    component("AB02Kastrullen.IBN01M4nut015", 0.000817)
    component("AB02Kastrullen.IBN01M4nut016", 0.000817)
    component("AB02Kastrullen.IBN01M4nut017", 0.000817)
    component("AB02Kastrullen.IBN01M4nut018", 0.000817)
    component("AB02Kastrullen.IBN01M4nut019", 0.000817)
    component("AB02Kastrullen.IBN01M4nut020", 0.000817)
    component("AB02Kastrullen.IBN01M4nut021", 0.000817)
    component("AB02Kastrullen.IBN01M4nut022", 0.000817)
    component("AB02Kastrullen.IBN01M4nut023", 0.000817)
    component("AB02Kastrullen.IBN01M4nut024", 0.000817)
    component("AB02Kastrullen.IBN01M4nut025", 0.000817)

    component("AB02Kastrullen.AB07MainValve.BBI00BValveHousing45", 0.514618)
    component("AB02Kastrullen.AB07MainValve.BBI01BValvePiston", 0.048214)
    component("AB02Kastrullen.AB07MainValve.BBI04EndCap", 0.026496)
    component("AB02Kastrullen.AB07MainValve.BBI05ValvePistonHead", 0.041932)
    component("AB02Kastrullen.AB07MainValve.IBD07M54mm90Injector", 0.012561)
    component("AB02Kastrullen.AB07MainValve.IBS03torxM6x16", 0.006205)

    % 6 x M4x10 torx
    component("AB02Kastrullen.AB07MainValve.IBS04torxM4x10", 0.001788)
    component("AB02Kastrullen.AB07MainValve.IBS04torxM4x011", 0.001788)
    component("AB02Kastrullen.AB07MainValve.IBS04torxM4x012", 0.001788)
    component("AB02Kastrullen.AB07MainValve.IBS04torxM4x013", 0.001788)
    component("AB02Kastrullen.AB07MainValve.IBS04torxM4x014", 0.001788)
    component("AB02Kastrullen.AB07MainValve.IBS04torxM4x015", 0.001788)

    % 16 x M4x22 headless screw
    component("AB02Kastrullen.AB07MainValve.IBS07M4x22headlessscrew", 0.00167)
    component("AB02Kastrullen.AB07MainValve.IBS07M4x22headlessscrew001", 0.00167)
    component("AB02Kastrullen.AB07MainValve.IBS07M4x22headlessscrew002", 0.00167)
    component("AB02Kastrullen.AB07MainValve.IBS07M4x22headlessscrew003", 0.00167)
    component("AB02Kastrullen.AB07MainValve.IBS07M4x22headlessscrew004", 0.00167)
    component("AB02Kastrullen.AB07MainValve.IBS07M4x22headlessscrew005", 0.00167)
    component("AB02Kastrullen.AB07MainValve.IBS07M4x22headlessscrew006", 0.00167)
    component("AB02Kastrullen.AB07MainValve.IBS07M4x22headlessscrew007", 0.00167)
    component("AB02Kastrullen.AB07MainValve.IBS07M4x22headlessscrew008", 0.00167)
    component("AB02Kastrullen.AB07MainValve.IBS07M4x22headlessscrew009", 0.00167)
    component("AB02Kastrullen.AB07MainValve.IBS07M4x22headlessscrew010", 0.00167)
    component("AB02Kastrullen.AB07MainValve.IBS07M4x22headlessscrew011", 0.00167)
    component("AB02Kastrullen.AB07MainValve.IBS07M4x22headlessscrew012", 0.00167)
    component("AB02Kastrullen.AB07MainValve.IBS07M4x22headlessscrew013", 0.00167)
    component("AB02Kastrullen.AB07MainValve.IBS07M4x22headlessscrew014", 0.00167)
    component("AB02Kastrullen.AB07MainValve.IBS07M4x22headlessscrew015", 0.00167)

    component("AB02Kastrullen.AB07MainValve.IBS08torxM5x6", 0.002415)
    component("AB02Kastrullen.AB07MainValve.IBO06151x245", 0)
    component("AB02Kastrullen.AB07MainValve.IBO0615x245", 0)
    component("AB02Kastrullen.AB07MainValve.IBO0745x25", 0)
    component("AB02Kastrullen.AB07MainValve.IBO08ellipticoring", 0)
    component("AB02Kastrullen.BBE08OxidizerpipeV2", 0.358071)
    component("AB02Kastrullen.AB08ValveAllwaysOpen.BBL02Nozzle", 0.003597)
    component("AB02Kastrullen.AB08ValveAllwaysOpen.BBL04NewNozzlebracket", 0.006144)
    component("AB02Kastrullen.AB08ValveAllwaysOpen.BBL05Lcoupling", 0.004488)
    component("AB02Kastrullen.AB08ValveAllwaysOpen.IBD02M54mmInjector", 0.005791)
    component("AB02Kastrullen.AB08ValveAllwaysOpen.IBD02M54mmInjector001", 0.005791)
    component("AB02Kastrullen.AB06KastrullenSplitter.BBE01Splitter", 0.173313)
    component("AB02Kastrullen.AB06KastrullenSplitter.BBE03TankNutSupportRing", 0.009156)
    component("AB02Kastrullen.AB06KastrullenSplitter.IBD01PipeNutM36", 0.094085)
    component("AB02Kastrullen.AB06KastrullenSplitter.BBE04PipeLockingRing", 0.002024)
    component("AB02Kastrullen.AB06KastrullenSplitter.BBE0514BSPThreadedTube", 0.012002)
    component("AB02Kastrullen.AB06KastrullenSplitter.IBD07M54mm90Injector002", 0.012561)
    component("AB02Kastrullen.AB06KastrullenSplitter.IBD07M54mm90Injector003", 0.012561)

    % Missing masses
    component("AB02Kastrullen.AB06KastrullenSplitter.BBE22BSP18maletoM5female", 0)
    component("AB02Kastrullen.AB06KastrullenSplitter.BBE23BSP14maletoM5female", 0) 
    component("AB02Kastrullen.AB06KastrullenSplitter.IBW02BSP14sealingwasher002", 0) 
    component("AB02Kastrullen.AB06KastrullenSplitter.IBD0818NPTHexDriveplug", 0) 
    component("AB02Kastrullen.BBE14Kastrullentopcap", 0) 
    component("AB02Kastrullen.IBS25M8x20LowProfileSocketHeadScrew", 0) 
    component("AB02Kastrullen.IBS25M8x20LowProfileSocketHeadScrew001", 0) 
    component("AB02Kastrullen.IBS25M8x20LowProfileSocketHeadScrew002", 0) 
    component("AB02Kastrullen.IBS25M8x20LowProfileSocketHeadScrew003", 0) 
    component("AB02Kastrullen.IBS25M8x20LowProfileSocketHeadScrew004", 0) 
    component("AB02Kastrullen.IBS25M8x20LowProfileSocketHeadScrew005", 0) 
    component("AB02Kastrullen.IBS25M8x20LowProfileSocketHeadScrew006", 0) 
    component("AB02Kastrullen.IBS25M8x20LowProfileSocketHeadScrew007", 0) 


    component("AB02Kastrullen.AB06KastrullenSplitter.IBD00QuickDisconnectMale", 0.08593)
    component("AB02Kastrullen.AB06KastrullenSplitter.BBE10XSplitterSupport2holes", 0.016886)
    component("AB02Kastrullen.AB06KastrullenSplitter.BBE11YSplitterSupport", 0.016886)
    component("AB02Kastrullen.AB06KastrullenSplitter.BBE12XSplitterSupport", 0.016886)
    component("AB02Kastrullen.AB06KastrullenSplitter.BBE13YSplitterSupport", 0.016886)

    % 4 x DIN912 M4x0.7 8mm screw
    component("AB02Kastrullen.AB06KastrullenSplitter.IBS01DIN912M4x078mm", 0.001667)
    component("AB02Kastrullen.AB06KastrullenSplitter.IBS01DIN912M4x078mm001", 0.001667)
    component("AB02Kastrullen.AB06KastrullenSplitter.IBS01DIN912M4x078mm002", 0.001667)
    component("AB02Kastrullen.AB06KastrullenSplitter.IBS01DIN912M4x078mm003", 0.001667)



    % Oxidiser tank
    component("AB03Oxidisertank", 18.8) % Weighed total mass


    % Fuselage
    component("AF001AftFuselage.BE011CombustionChamberCFRPTube003", 2.029142)

    % 4 x Aero fin
    component("AF001AftFuselage.BF00AeroFin004", 0.108172)
    component("AF001AftFuselage.BF00AeroFin009", 0.108172)
    component("AF001AftFuselage.BF00AeroFin014", 0.108172)
    component("AF001AftFuselage.BF00AeroFin019", 0.108172)

    component("AF001AftFuselage.BF04ExtraFinLeft", 0.0)
    component("AF001AftFuselage.BF05ExtraFinRight", 0.0)

    component("AF001AftFuselage.BT001TailSkirt", 0.10363)

    % 12 x M4x0.5, 8mm countersunk screw
    component("AF001AftFuselage.IDA01M4x058mm", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm001", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm002", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm003", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm004", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm005", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm006", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm007", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm008", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm009", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm010", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm011", 0.000985)



    % Recovery
    component("AR00Recoverysystem.BCO07TankRSconnector", 0.58979)

    % 26 x M4x0.5, 8mm countersunk screw
    component("AR00Recoverysystem.IDA01M4x058mm012", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm013", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm014", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm015", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm016", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm017", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm018", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm019", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm020", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm021", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm022", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm023", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm024", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm025", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm026", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm027", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm028", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm029", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm030", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm031", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm032", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm033", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm034", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm035", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm036", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm037", 0.000985)

    component("AR00Recoverysystem.BE02RecoveryCFRPTube", 1.397953)
    component("AR00Recoverysystem.BCO04Compartmentplacer", 0.344096)
    component("AR00Recoverysystem.BCO02Compartmenttube", 0.294825)
    component("AR00Recoverysystem.BCO05Tubeinsert", 0.186244)
    component("AR00Recoverysystem.BCO03Separationplate", 0.127887)
    component("AR00Recoverysystem.BCO06Piston", 0.472713)
    component("AR00Recoverysystem.BCO01Compartmentbase", 0.187209)

    % 4 x Charge holder
    component("AR00Recoverysystem.AR02ejectablebolts.BCB03Chargeholder", 0.012283)
    component("AR00Recoverysystem.AR02ejectablebolts001.BCB03Chargeholder001", 0.012283)
    component("AR00Recoverysystem.BCB03Chargeholder002", 0.012283)
    component("AR00Recoverysystem.BCB03Chargeholder003", 0.012283)

    component("AR00Recoverysystem.BCO09CFRPring", 0.244591)
    component("AR00Recoverysystem.BCO10spacer", 0.010213)
    component("AR00Recoverysystem.BCO11absorptiondevice", 0.023004)
    component("AR00Recoverysystem.BCO11absorptiondevice001", 0.023004)
    component("AR00Recoverysystem.IDA03DIN444M6eyeboltfullthread", 0.012629)
    component("AR00Recoverysystem.IDA03DIN444M6eyeboltfullthread001", 0.012629)
    component("AR00Recoverysystem.IDA04DIN582M6eyenut", 0.043626)
    component("AR00Recoverysystem.AR01mainparachutebracket.BCA01bracketbase", 0.019243)
    component("AR00Recoverysystem.AR01mainparachutebracket.IDA05M6ISO7379d825mmshoulderscrew", 0.017343)
    component("AR00Recoverysystem.AR01mainparachutebracket.IDA06M6nutDIN934", 0.002565)
    component("AR00Recoverysystem.AR02ejectablebolts.BCB01Boltbase", 0.063545)
    component("AR00Recoverysystem.AR02ejectablebolts001.BCB01Boltbase001", 0.063545)
    component("AR00Recoverysystem.AR02ejectablebolts.BCB02Pyrobolt", 0.009508)
    component("AR00Recoverysystem.AR02ejectablebolts001.BCB02Pyrobolt001", 0.009508)



    % Nose cone
    
    % 24 x M4x0.5, 8mm countersunk screw
    component("AN00NoseCone.IDA01M4x058mm038", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm039", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm040", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm041", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm042", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm043", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm044", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm045", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm046", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm047", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm048", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm049", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm050", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm051", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm052", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm053", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm054", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm055", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm056", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm057", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm058", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm059", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm060", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm061", 0.000985)

    component("AN00NoseCone.BD00NoseCone", 0.417999)
    component("AN00NoseCone.BD01EbayRing", 0.634103)
    component("AN00NoseCone.BD03TipInsert", 0.101677)
    component("AN00NoseCone.BD04Tip", 0.085505)
    component("AN00NoseCone.BD05NoseConeRing", 0.273242)
    component("AN00NoseCone.BD06ParallelDowelPin24mm", 0.009289)
    component("AN00NoseCone.BD07PitotTube", 0.012201)
];

mass_geometry = rocket;
mass_geometry.position = zeros(3,1);
mass_geometry.attitude = eye(3);
mass_geometry.is_rigid_body = true;

for i = 1:numel(mapping)
    item = mapping(i);
    fields = cellstr(split(item.path, '.'));
    cad_component = getfield(mass_geometry, fields{:});
    cad_component.mass = item.mass;
    cad_component.is_rigid_body = true;
    mass_geometry = setfield_safe(mass_geometry, fields, cad_component);

    for depth = 1:numel(fields)
        mass_geometry = setfield_safe(mass_geometry, ...
            [fields(1:depth); {'is_rigid_body'}], true);
    end
end

mass_geometry = update_transforms(mass_geometry);

fuel_grain_fields = cellstr(split("AB01Thrustchamber.BBC00MFuelgrainwithcylindricalinitialport002.BBC00MFuelgrainwithcylindricalinitialport", '.'));
fuel_grain = getfield(mass_geometry, fuel_grain_fields{:});
rocket.mjollnir_fuelgrain_position = fuel_grain.position_global ...
    + fuel_grain.attitude_global * [0; 0; 0.32868/2];

oxidizer_fields = cellstr(split("AB03Oxidisertank", '.'));
oxidizer = getfield(mass_geometry, oxidizer_fields{:});
rocket.mjollnir_oxidizer_position = oxidizer.position_global + [0; 0; 1];

mass_geometry.oxidizer_tank_mass = struct( ...
    'mass', oxidizer.mass, ...
    'position', oxidizer.position_global + [0; 0; 1], ...
    'attitude', eye(3), ...
    'is_rigid_body', true);
mass_geometry.AB03Oxidisertank.mass = 0;

mass_geometry = base_update_center_of_mass(mass_geometry, true);
mass_geometry = base_update_center_of_mass(mass_geometry, false);
rocket.mjollnir_dry_mass = mass_geometry.mass_summed;
rocket.mjollnir_dry_cg = mass_geometry.center_of_mass_summed;

disp("Fuelgrain CG: ")
disp(rocket.mjollnir_fuelgrain_position)
disp("Oxidizer CG: ")
disp(rocket.mjollnir_oxidizer_position)

disp("Total drymass:")
disp(mass_geometry.mass_summed)

disp("Dry CG:")
disp(mass_geometry.center_of_mass_summed)
end

function item = component(path, mass)
    item = struct('path', path, 'mass', mass);
end