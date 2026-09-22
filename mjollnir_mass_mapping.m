function rocket = mjollnir_mass_mapping(rocket, declare_dependencies)
if ~declare_dependencies
    return
end

mapping = [
    % Thrust chamber
    component("AB01Thrustchamber.BBF02Precombustionchambercover", 0.441737)
    component("AB01Thrustchamber.AB04NozzleandPCC.BBK03PCCinletgraphiteinsert", 0.372)
    component("AB01Thrustchamber.AB04NozzleandPCC.BBK04PCCLid", 1.493475)
    component("AB01Thrustchamber.AB04NozzleandPCC.BBK05Nozzle", 1.696256)
    component("AB01Thrustchamber.AB04NozzleandPCC.BBK06NozzleHolder", 1.494064)
    component("AB01Thrustchamber.AB04NozzleandPCC.BBK08FuelGrainAxialClamp", 0.264272)
    component("AB01Thrustchamber.AB04NozzleandPCC.IBO002x13016", 0)
    component("AB01Thrustchamber.AB04NozzleandPCC.IBO01275x1387", 0)
    component("AB01Thrustchamber.AB04NozzleandPCC.IBO01275x13872", 0)
    component("AB01Thrustchamber.AB05InjectorV2.BBA05InjectorCasingV2", 0.874649)

    % 8 x M6 hex 25mm InUes screw
    component("AB01Thrustchamber.AB05InjectorV2.IBB01M6Hex25mmInUes", 0.007483)
    component("AB01Thrustchamber.AB05InjectorV2.IBB01M6Hex25mmInUes2", 0.007483)
    component("AB01Thrustchamber.AB05InjectorV2.IBB01M6Hex25mmInUes3", 0.007483)
    component("AB01Thrustchamber.AB05InjectorV2.IBB01M6Hex25mmInUes4", 0.007483)
    component("AB01Thrustchamber.AB05InjectorV2.IBB01M6Hex25mmInUes5", 0.007483)
    component("AB01Thrustchamber.AB05InjectorV2.IBB01M6Hex25mmInUes6", 0.007483)
    component("AB01Thrustchamber.AB05InjectorV2.IBB01M6Hex25mmInUes7", 0.007483)
    component("AB01Thrustchamber.AB05InjectorV2.IBB01M6Hex25mmInUes8", 0.007483)

    component("AB01Thrustchamber.AB05InjectorV2.IBC00M304100000601KPGpressuretransducer", 0.098217)
    component("AB01Thrustchamber.AB05InjectorV2.IBC00M304100000601KPGpressuretransducer5", 0.098217)

    % 8 x M6 hex 22mm InUes screw
    component("AB01Thrustchamber.AB05InjectorV2.IBB05M6HEx22mmInUes", 0.006945)
    component("AB01Thrustchamber.AB05InjectorV2.IBB05M6HEx22mmInUes2", 0.006945)
    component("AB01Thrustchamber.AB05InjectorV2.IBB05M6HEx22mmInUes3", 0.006945)
    component("AB01Thrustchamber.AB05InjectorV2.IBB05M6HEx22mmInUes4", 0.006945)
    component("AB01Thrustchamber.AB05InjectorV2.IBB05M6HEx22mmInUes5", 0.006945)
    component("AB01Thrustchamber.AB05InjectorV2.IBB05M6HEx22mmInUes6", 0.006945)
    component("AB01Thrustchamber.AB05InjectorV2.IBB05M6HEx22mmInUes7", 0.006945)
    component("AB01Thrustchamber.AB05InjectorV2.IBB05M6HEx22mmInUes8", 0.006945)
    component("AB01Thrustchamber.AB05InjectorV2.BBA06InjectorPlateV2", 0.286488)
    component("AB01Thrustchamber.AB05InjectorV2.IBC06M8x40AESIRtemperaturesensor", 0.02257)
    component("AB01Thrustchamber.AB05InjectorV2.BBE21M8maletoM5femaleadapter", 0.005408)
    component("AB01Thrustchamber.BBF00Combustionchambercasing", 3.55)

    % M6x14 countersunk screw
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind2", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind3", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind4", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind5", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind6", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind7", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind8", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind9", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind10", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind11", 0.003527)
    component("AB01Thrustchamber.IBS02Thrustchamberscrewofsomekind12", 0.003527)

    % 12 x M8x35 Socket cap screw
    component("AB01Thrustchamber.IBS16M8x35SocketCap", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap2", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap3", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap4", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap5", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap6", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap7", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap8", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap9", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap10", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap11", 0.021343)
    component("AB01Thrustchamber.IBS16M8x35SocketCap12", 0.021343)



    % Kastrullen
    component("AB07MainValve.BBI07SensorBracket", 0) % missing from excel
    component("AB06KastrullenSplitter.IBD03X10N2OSolenoid", 0) % missing from excel
    component("AB06KastrullenSplitter.IBC00M304100000601KPGpressuretransducer9", 0) % missing from excel
    
    % 4 x Thrust strut
    component("BBE00Thruststrut", 0.143647)
    component("BBE00Thruststrut2", 0.143647)
    component("BBE00Thruststrut3", 0.143647)
    component("BBE00Thruststrut4", 0.143647)

    % 8 x M4x16 torx screw
    component("IBS05torxM4x16", 0.002266)
    component("IBS05torxM4x162", 0.002266)
    component("IBS05torxM4x163", 0.002266)
    component("IBS05torxM4x164", 0.002266)
    component("IBS05torxM4x165", 0.002266)
    component("IBS05torxM4x166", 0.002266)
    component("IBS05torxM4x167", 0.002266)
    component("IBS05torxM4x168", 0.002266)

    component("AB07MainValve.IBS05torxM4x169", 0.002266)
    component("AB07MainValve.IBS05torxM4x1610", 0.002266)

    % 8 x M4x12 screw missing

    % 10 x M4x16 torx screw
    component("IBS05torxM4x1611", 0.002266)
    component("IBS05torxM4x1612", 0.002266)
    component("IBS05torxM4x1613", 0.002266)
    component("IBS05torxM4x1614", 0.002266)
    component("IBS05torxM4x1615", 0.002266)
    component("IBS05torxM4x1616", 0.002266)
    component("IBS05torxM4x1617", 0.002266)
    component("IBS05torxM4x1618", 0.002266)
    component("IBS05torxM4x1619", 0.002266)
    component("IBS05torxM4x1620", 0.002266)
    % Two extra vs excel

    % 8 x M4 locknut
    component("AB07MainValve.IBN00M4locknut", 0.001216)
    component("AB07MainValve.IBN00M4locknut2", 0.001216)
    component("AB07MainValve.IBN00M4locknut3", 0.001216)
    component("AB07MainValve.IBN00M4locknut4", 0.001216)
    component("AB07MainValve.IBN00M4locknut5", 0.001216)
    component("AB07MainValve.IBN00M4locknut6", 0.001216)
    component("AB07MainValve.IBN00M4locknut7", 0.001216)
    component("AB07MainValve.IBN00M4locknut8", 0.001216)
    % 8 missing

    % 26 x M4 nut
    component("IBN01M4nut", 0.000817)
    component("IBN01M4nut2", 0.000817)
    component("IBN01M4nut3", 0.000817)
    component("IBN01M4nut4", 0.000817)
    component("IBN01M4nut5", 0.000817)
    component("IBN01M4nut6", 0.000817)
    component("IBN01M4nut7", 0.000817)
    component("IBN01M4nut8", 0.000817)
    component("IBN01M4nut9", 0.000817)
    component("IBN01M4nut10", 0.000817)
    component("IBN01M4nut11", 0.000817)
    component("IBN01M4nut12", 0.000817)
    component("IBN01M4nut13", 0.000817)
    component("IBN01M4nut14", 0.000817)
    component("IBN01M4nut15", 0.000817)
    component("IBN01M4nut16", 0.000817)
    component("IBN01M4nut17", 0.000817)
    component("IBN01M4nut18", 0.000817)
    component("IBN01M4nut19", 0.000817)
    component("IBN01M4nut20", 0.000817)
    component("IBN01M4nut21", 0.000817)
    component("IBN01M4nut22", 0.000817)
    component("IBN01M4nut23", 0.000817)
    component("IBN01M4nut24", 0.000817)
    component("IBN01M4nut25", 0.000817)
    component("IBN01M4nut26", 0.000817)

    component("AB07MainValve.BBI00BValveHousing45", 0.514618)
    component("AB07MainValve.BBI01BValvePiston", 0.048214)
    component("AB07MainValve.BBI04EndCap", 0.026496)
    component("AB07MainValve.BBI05ValvePistonHead", 0.041932)
    component("AB07MainValve.IBD07M54mm90Injector", 0.012561)
    component("AB07MainValve.IBS03torxM6x16", 0.006205)

    % 4 x M4x10 torx
    component("AB07MainValve.IBS04torxM4x10", 0.001788)
    component("AB07MainValve.IBS04torxM4x102", 0.001788)
    component("AB07MainValve.IBS04torxM4x103", 0.001788)
    component("AB07MainValve.IBS04torxM4x104", 0.001788)
    % Two missing

    % 16 x M4x22 headless screw
    component("AB07MainValve.IBS07M4x22headlessscrew", 0.00167)
    component("AB07MainValve.IBS07M4x22headlessscrew2", 0.00167)
    component("AB07MainValve.IBS07M4x22headlessscrew3", 0.00167)
    component("AB07MainValve.IBS07M4x22headlessscrew4", 0.00167)
    component("AB07MainValve.IBS07M4x22headlessscrew5", 0.00167)
    component("AB07MainValve.IBS07M4x22headlessscrew6", 0.00167)
    component("AB07MainValve.IBS07M4x22headlessscrew7", 0.00167)
    component("AB07MainValve.IBS07M4x22headlessscrew8", 0.00167)
    component("AB07MainValve.IBS07M4x22headlessscrew9", 0.00167)
    component("AB07MainValve.IBS07M4x22headlessscrew10", 0.00167)
    component("AB07MainValve.IBS07M4x22headlessscrew11", 0.00167)
    component("AB07MainValve.IBS07M4x22headlessscrew12", 0.00167)
    component("AB07MainValve.IBS07M4x22headlessscrew13", 0.00167)
    component("AB07MainValve.IBS07M4x22headlessscrew14", 0.00167)
    component("AB07MainValve.IBS07M4x22headlessscrew15", 0.00167)
    component("AB07MainValve.IBS07M4x22headlessscrew16", 0.00167)

    component("AB07MainValve.IBS08torxM5x6", 0.002415)
    component("AB07MainValve.IBO06151x245", 0)
    component("AB07MainValve.IBO0615x245", 0)
    component("AB07MainValve.IBO0745x25", 0)
    component("AB07MainValve.IBO08ellipticoring", 0)
    component("BBE08OxidizerpipeV2", 0.358071)
    component("AB08ValveAllwaysOpen.BBL02Nozzle", 0.003597)
    component("AB08ValveAllwaysOpen.BBL04NewNozzlebracket", 0.006144)
    component("AB08ValveAllwaysOpen.BBL05Lcoupling", 0.004488)
    component("AB06KastrullenSplitter.BBE01Splitter", 0.173313)
    component("AB06KastrullenSplitter.BBE03TankNutSupportRing", 0.009156)
    component("AB06KastrullenSplitter.BBE08PipeNutM36", 0.094085)
    component("AB06KastrullenSplitter.BBE04PipeLockingRing", 0.002024)
    component("AB06KastrullenSplitter.BBE0514BSPThreadedTube", 0.012002)
    component("AB06KastrullenSplitter.BBE0514BSPThreadedTube2", 0.012002)

    component("AB06KastrullenSplitter.IBD00QuickDisconnectMale", 0.08593)
    component("AB06KastrullenSplitter.IBD05FestoSolenoidVZWDLM22CMG1415V1P485R1V2", 2 * 0.409276) % Double mass to compensate for missing part in cad
    component("AB06KastrullenSplitter.BBE0618BSPThreadedTube", 0.010153)
    component("AB06KastrullenSplitter.IBD02M54mmInjector", 0.005791)
    component("AB06KastrullenSplitter.BBE078x1mmtoM5Adapter", 0.006002)
    component("AB06KastrullenSplitter.BBE10XSplitterSupport2holes", 0.016886)
    component("AB06KastrullenSplitter.BBE11YSplitterSupport", 0.016886)
    component("AB06KastrullenSplitter.BBE12XSplitterSupport", 0.016886)
    component("AB06KastrullenSplitter.BBE13YSplitterSupport", 0.016886)

    % 4 x DIN912 M4x0.7 8mm screw
    component("AB06KastrullenSplitter.IBS01DIN912M4x078mm", 0.001667)
    component("AB06KastrullenSplitter.IBS01DIN912M4x078mm2", 0.001667)
    component("AB06KastrullenSplitter.IBS01DIN912M4x078mm3", 0.001667)
    component("AB06KastrullenSplitter.IBS01DIN912M4x078mm4", 0.001667)



    % Oxidiser tank
    component("AB03Oxidisertankv2.BBD03Oxidisertanktop", 0) % missing from excel
    component("AB03Oxidisertankv2.BBD04Oxidisertankpipe", 0) % missing from excel
    component("AB03Oxidisertankv2.BBD08Tankbottom", 0) % missing from excel
    component("AB03Oxidisertankv2.BBD09Flangekastrullenconnector", 0) % missing from excel
    component("AB03Oxidisertankv2.BBE14Kastrullentopcap", 0) % missing from excel
    % IBS25: 8 x M8x20 Low Profile Socket Head Screw - missing from excel
    % IBS28: 8 x M6x15 screw - missing from excel
    % IBS35: 64 x M6x18 countersunk DIN7991 screw - missing from excel

    component("AB03Oxidisertankv2.IBC00M304100000601KPGpressuretransducer13", 0.098217)
    component("AB03Oxidisertankv2.IBC00M304100000601KPGpressuretransducer17", 0.098217)
    component("AB03Oxidisertankv2.BBJ00Liquidlevelprobe", 0.020252)
    component("AB03Oxidisertankv2.BBJ01Liquidlevelprobebolt", 0.004085)
    component("AB03Oxidisertankv2.IBC06M8x40AESIRtemperaturesensor2", 0.02257)



    % Fuselage
    component("AF001AftFuselage.BE011CombustionChamberCFRPTube", 2.029142)

    % 4 x Aero fin
    component("AF001AftFuselage.BF00AeroFin", 0.108172)
    component("AF001AftFuselage.BF00AeroFin6", 0.108172)
    component("AF001AftFuselage.BF00AeroFin11", 0.108172)
    component("AF001AftFuselage.BF00AeroFin16", 0.108172)

    component("AF001AftFuselage.BT001TailSkirt", 0.10363)

    % 12 x M4x0.5, 8mm countersunk screw
    component("AF001AftFuselage.IDA01M4x058mm", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm2", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm3", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm4", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm5", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm6", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm7", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm8", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm9", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm10", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm11", 0.000985)
    component("AF001AftFuselage.IDA01M4x058mm12", 0.000985)



    % Recovery
    component("AR00Recoverysystem.BCO07TankRSconnector", 0.58979)

    % 14 x M4x0.5, 8mm countersunk screw
    component("AR00Recoverysystem.IDA01M4x058mm13", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm14", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm15", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm16", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm17", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm18", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm19", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm20", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm21", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm22", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm23", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm24", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm25", 0.000985)
    component("AR00Recoverysystem.IDA01M4x058mm26", 0.000985)

    component("AR00Recoverysystem.BE02RecoveryCFRPTube", 1.397953)
    component("AR00Recoverysystem.Compartmentplacer", 0.344096)
    component("AR00Recoverysystem.BCO02Compartmenttube", 0.294825)
    component("AR00Recoverysystem.BCO05Tubeinsert", 0.186244)
    component("AR00Recoverysystem.Separationplate", 0.127887)
    component("AR00Recoverysystem.BCO06Piston", 0.472713)
    component("AR00Recoverysystem.BCO01Compartmentbase", 0.187209)

    % 4 x Charge holder
    component("AR00Recoverysystem.AR02ejectablebolts.BCB03Chargeholder", 0.012283)
    component("AR00Recoverysystem.AR02ejectablebolts2.BCB03Chargeholder2", 0.012283)
    component("AR00Recoverysystem.BCB03Chargeholder3", 0.012283)
    component("AR00Recoverysystem.BCB03Chargeholder4", 0.012283)

    component("AR00Recoverysystem.BCO09CFRPring", 0.244591)
    component("AR00Recoverysystem.BCO10spacer", 0.010213)
    component("AR00Recoverysystem.BCO11absorptiondevice", 0.023004)
    component("AR00Recoverysystem.BCO11absorptiondevice2", 0.023004)
    component("AR00Recoverysystem.IDA03DIN444M6eyeboltfullthread", 0.012629)
    component("AR00Recoverysystem.IDA03DIN444M6eyeboltfullthread2", 0.012629)
    component("AR00Recoverysystem.IDA04DIN582M6eyenut", 0.043626)
    component("AR00Recoverysystem.AR01mainparachutebracket.BCA01bracketbase", 0.019243)
    component("AR00Recoverysystem.AR01mainparachutebracket.IDA05M6ISO7379d825mmshoulderscrew", 0.017343)
    component("AR00Recoverysystem.AR01mainparachutebracket.IDA06M6nutDIN934", 0.002565)
    component("AR00Recoverysystem.AR02ejectablebolts.BCB01Boltbase", 0.063545)
    component("AR00Recoverysystem.AR02ejectablebolts2.BCB01Boltbase2", 0.063545)
    component("AR00Recoverysystem.AR02ejectablebolts.BCB02Pyrobolt", 0.009508)
    component("AR00Recoverysystem.AR02ejectablebolts2.BCB02Pyrobolt2", 0.009508)



    % Nose cone
    
    % 24 x M4x0.5, 8mm countersunk screw
    component("AN00NoseCone.IDA01M4x058mm27", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm28", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm29", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm30", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm31", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm32", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm33", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm34", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm35", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm36", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm37", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm38", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm39", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm40", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm41", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm42", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm43", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm44", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm45", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm46", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm47", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm48", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm49", 0.000985)
    component("AN00NoseCone.IDA01M4x058mm50", 0.000985)

    component("AN00NoseCone.BD00NoseCone", 0.417999)
    component("AN00NoseCone.BD01EbayRing", 0.634103)
    component("AN00NoseCone.BD03TipInsert", 0.101677)
    component("AN00NoseCone.BD04Tip", 0.085505)
    component("AN00NoseCone.BD05NoseConeRing", 0.273242)
    component("AN00NoseCone.BD06ParallelDowelPin24mm", 0.009289)
    component("AN00NoseCone.BD07PitotTube", 0.012201)
    % IDA_07: M6x40 screw
    % IDA_08: M3 cone-point set screw
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

mass_geometry = base_update_center_of_mass(mass_geometry, true);
mass_geometry = base_update_center_of_mass(mass_geometry, false);
rocket.mjollnir_dry_mass = mass_geometry.mass_summed;
rocket.mjollnir_dry_cg = mass_geometry.center_of_mass_summed;

disp(mass_geometry.mass_summed)
disp(mass_geometry.center_of_mass_summed)
end

function item = component(path, mass)
    item = struct('path', path, 'mass', mass);
end
