within ;
package Journal_IES_Simulations

  package ReactorBOP_Sim
    package SteadyState_Sim

      package Generic_Modular
        model Test_threeCoupledBOP_wo_anycontrol
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS
            annotation (Placement(transformation(extent={{-90,38},{-36,92}})));
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1
            annotation (Placement(transformation(extent={{-90,-24},{-36,30}})));
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2
            annotation (Placement(transformation(extent={{-90,-86},{-36,-32}})));
          NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(port_a_nominal(
              p=PHS.port_b_nominal.p,
              h=PHS.port_b_nominal.h,
              m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
            port_b_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h))
            annotation (Placement(transformation(extent={{10,-20},{60,30}})));
          NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG
            annotation (Placement(transformation(extent={{86,-20},{138,30}})));
          TRANSFORM.Fluid.Volumes.MixingVolume volume(
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            use_T_start=false,
            redeclare model Geometry =
                TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
                (V=0.001),
            nPorts_b=1,
            p_start=PHS.port_b_nominal.p,
            h_start=PHS.port_b_nominal.h,
            nPorts_a=3,
            showName=false)
            annotation (Placement(transformation(extent={{-26,68},{-6,88}})));
          TRANSFORM.Fluid.Volumes.MixingVolume volume1(
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            use_T_start=false,
            redeclare model Geometry =
                TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
                (V=0.001),
            nPorts_a=1,
            p_start=PHS.port_a_nominal.p,
            h_start=PHS.port_a_nominal.h,
            nPorts_b=3,
            showName=false)
            annotation (Placement(transformation(extent={{-2,-90},{-22,-70}})));
          Modelica.Blocks.Sources.Step Demand(
            height=25e06,
            offset=125e06,
            startTime=3000)
            annotation (Placement(transformation(extent={{112,-76},{132,-56}})));
        equation
          connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-36,
                  75.8},{-29,75.8},{-29,77.3333},{-22,77.3333}},
                                                      color={0,127,255}));
          connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-36,13.8},{-28,
                  13.8},{-28,78},{-22,78}}, color={0,127,255}));
          connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-36,
                  -48.2},{-30,-48.2},{-30,78.6667},{-22,78.6667}},
                                                       color={0,127,255}));
          connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-36,
                  54.2},{-28,54.2},{-28,-80.6667},{-18,-80.6667}},
                                                        color={0,127,255}));
          connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-36,-7.8},{-36,
                  -8},{-24,-8},{-24,-78},{-18,-78},{-18,-80}}, color={0,127,255}));
          connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-36,
                  -69.8},{-28,-69.8},{-28,-79.3333},{-18,-79.3333}},
                                                             color={0,127,255}));
          connect(volume.port_b[1], BOP.port_a) annotation (Line(points={{-10,78},{2,78},
                  {2,15},{10,15}}, color={0,127,255}));
          connect(volume1.port_a[1], BOP.port_b) annotation (Line(points={{-6,-80},{2,-80},
                  {2,-5},{10,-5}}, color={0,127,255}));
          connect(BOP.portElec_b, EG.portElec_a)
            annotation (Line(points={{60,5},{73,5},{73,5},{86,5}}, color={255,0,0}));
          annotation (
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{160,
                    100}})),
            experiment(
              StopTime=5000,
              __Dymola_NumberOfIntervals=2000,
              __Dymola_Algorithm="Esdirk45a"),
            __Dymola_experimentSetupOutput(events=false),
            Icon(coordinateSystem(extent={{-100,-100},{160,100}})));
        end Test_threeCoupledBOP_wo_anycontrol;

        model Test_threeCoupledBOP_wSteadyControl
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(redeclare
              NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
            annotation (Placement(transformation(extent={{-90,38},{-36,92}})));
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(redeclare
              NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
            annotation (Placement(transformation(extent={{-90,-24},{-36,30}})));
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(redeclare
              NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
            annotation (Placement(transformation(extent={{-90,-86},{-36,-32}})));
          NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(port_a_nominal(
              p=PHS.port_b_nominal.p,
              h=PHS.port_b_nominal.h,
              m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
            port_b_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h))
            annotation (Placement(transformation(extent={{10,-20},{60,30}})));
          NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG
            annotation (Placement(transformation(extent={{86,-20},{138,30}})));
          TRANSFORM.Fluid.Volumes.MixingVolume volume(
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            use_T_start=false,
            redeclare model Geometry =
                TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
                (V=0.001),
            nPorts_b=1,
            p_start=PHS.port_b_nominal.p,
            h_start=PHS.port_b_nominal.h,
            nPorts_a=3,
            showName=false)
            annotation (Placement(transformation(extent={{-26,68},{-6,88}})));
          TRANSFORM.Fluid.Volumes.MixingVolume volume1(
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            use_T_start=false,
            redeclare model Geometry =
                TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
                (V=0.001),
            nPorts_a=1,
            p_start=PHS.port_a_nominal.p,
            h_start=PHS.port_a_nominal.h,
            nPorts_b=3,
            showName=false)
            annotation (Placement(transformation(extent={{-2,-90},{-22,-70}})));
          Modelica.Blocks.Sources.Step Demand(
            height=25e06,
            offset=125e06,
            startTime=3000)
            annotation (Placement(transformation(extent={{88,-74},{108,-54}})));
        equation
          connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-36,
                  75.8},{-29,75.8},{-29,77.3333},{-22,77.3333}},
                                                      color={0,127,255}));
          connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-36,13.8},{-28,
                  13.8},{-28,78},{-22,78}}, color={0,127,255}));
          connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-36,
                  -48.2},{-30,-48.2},{-30,78.6667},{-22,78.6667}},
                                                       color={0,127,255}));
          connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-36,
                  54.2},{-28,54.2},{-28,-80.6667},{-18,-80.6667}},
                                                        color={0,127,255}));
          connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-36,-7.8},{-36,
                  -8},{-24,-8},{-24,-78},{-18,-78},{-18,-80}}, color={0,127,255}));
          connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-36,
                  -69.8},{-28,-69.8},{-28,-79.3333},{-18,-79.3333}},
                                                             color={0,127,255}));
          connect(volume.port_b[1], BOP.port_a) annotation (Line(points={{-10,78},{2,78},
                  {2,15},{10,15}}, color={0,127,255}));
          connect(volume1.port_a[1], BOP.port_b) annotation (Line(points={{-6,-80},{2,-80},
                  {2,-5},{10,-5}}, color={0,127,255}));
          connect(BOP.portElec_b, EG.portElec_a)
            annotation (Line(points={{60,5},{73,5},{73,5},{86,5}}, color={255,0,0}));
          annotation (
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{160,
                    100}})),
            experiment(
              StopTime=5000,
              __Dymola_NumberOfIntervals=2000,
              __Dymola_Algorithm="Esdirk45a"),
            __Dymola_experimentSetupOutput(events=false),
            Icon(coordinateSystem(extent={{-100,-100},{160,100}})));
        end Test_threeCoupledBOP_wSteadyControl;

        model Test_threeCoupledBOP_w_BOPControl
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS
            annotation (Placement(transformation(extent={{-90,38},{-36,92}})));
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1
            annotation (Placement(transformation(extent={{-90,-24},{-36,30}})));
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2
            annotation (Placement(transformation(extent={{-90,-86},{-36,-32}})));
          NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(port_a_nominal(
              p=PHS.port_b_nominal.p,
              h=PHS.port_b_nominal.h,
              m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
            port_b_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),    redeclare
              NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
              CS(
              p_nominal=BOP.port_a_nominal.p,
              W_totalSetpoint=Demand.y,
              delayStartTCV=0))
            annotation (Placement(transformation(extent={{10,-20},{60,30}})));
          NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG
            annotation (Placement(transformation(extent={{86,-20},{138,30}})));
          TRANSFORM.Fluid.Volumes.MixingVolume volume(
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            use_T_start=false,
            redeclare model Geometry =
                TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
                (V=0.001),
            nPorts_b=1,
            p_start=PHS.port_b_nominal.p,
            h_start=PHS.port_b_nominal.h,
            nPorts_a=3,
            showName=false)
            annotation (Placement(transformation(extent={{-26,68},{-6,88}})));
          TRANSFORM.Fluid.Volumes.MixingVolume volume1(
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            use_T_start=false,
            redeclare model Geometry =
                TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
                (V=0.001),
            nPorts_a=1,
            p_start=PHS.port_a_nominal.p,
            h_start=PHS.port_a_nominal.h,
            nPorts_b=3,
            showName=false)
            annotation (Placement(transformation(extent={{-2,-90},{-22,-70}})));
          Modelica.Blocks.Sources.Step Demand(
            height=25e06,
            offset=125e06,
            startTime=3000)
            annotation (Placement(transformation(extent={{90,-68},{110,-48}})));
        equation
          connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-36,
                  75.8},{-29,75.8},{-29,77.3333},{-22,77.3333}},
                                                      color={0,127,255}));
          connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-36,13.8},{-28,
                  13.8},{-28,78},{-22,78}}, color={0,127,255}));
          connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-36,
                  -48.2},{-30,-48.2},{-30,78.6667},{-22,78.6667}},
                                                       color={0,127,255}));
          connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-36,
                  54.2},{-28,54.2},{-28,-80.6667},{-18,-80.6667}},
                                                        color={0,127,255}));
          connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-36,-7.8},{-36,
                  -8},{-24,-8},{-24,-78},{-18,-78},{-18,-80}}, color={0,127,255}));
          connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-36,
                  -69.8},{-28,-69.8},{-28,-79.3333},{-18,-79.3333}},
                                                             color={0,127,255}));
          connect(volume.port_b[1], BOP.port_a) annotation (Line(points={{-10,78},{2,78},
                  {2,15},{10,15}}, color={0,127,255}));
          connect(volume1.port_a[1], BOP.port_b) annotation (Line(points={{-6,-80},{2,-80},
                  {2,-5},{10,-5}}, color={0,127,255}));
          connect(BOP.portElec_b, EG.portElec_a)
            annotation (Line(points={{60,5},{73,5},{73,5},{86,5}}, color={255,0,0}));
          annotation (
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{160,
                    100}})),
            experiment(
              StopTime=5000,
              __Dymola_NumberOfIntervals=2000,
              __Dymola_Algorithm="Esdirk45a"),
            __Dymola_experimentSetupOutput(events=false),
            Icon(coordinateSystem(extent={{-100,-100},{160,100}})));
        end Test_threeCoupledBOP_w_BOPControl;

        model Test_threeCoupledBOP_w_BOP_nSteadyControl
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(redeclare
              NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
            annotation (Placement(transformation(extent={{-90,38},{-36,92}})));
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(redeclare
              NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
            annotation (Placement(transformation(extent={{-90,-24},{-36,30}})));
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(redeclare
              NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
            annotation (Placement(transformation(extent={{-90,-86},{-36,-32}})));
          NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(port_a_nominal(
              p=PHS.port_b_nominal.p,
              h=PHS.port_b_nominal.h,
              m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
            port_b_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),    redeclare
              NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
              CS(
              p_nominal=BOP.port_a_nominal.p,
              W_totalSetpoint=Demand.y,
              delayStartTCV=0))
            annotation (Placement(transformation(extent={{10,-20},{60,30}})));
          NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG
            annotation (Placement(transformation(extent={{86,-20},{138,30}})));
          TRANSFORM.Fluid.Volumes.MixingVolume volume(
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            use_T_start=false,
            redeclare model Geometry =
                TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
                (V=0.001),
            nPorts_b=1,
            p_start=PHS.port_b_nominal.p,
            h_start=PHS.port_b_nominal.h,
            nPorts_a=3,
            showName=false)
            annotation (Placement(transformation(extent={{-26,68},{-6,88}})));
          TRANSFORM.Fluid.Volumes.MixingVolume volume1(
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            use_T_start=false,
            redeclare model Geometry =
                TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
                (V=0.001),
            nPorts_a=1,
            p_start=PHS.port_a_nominal.p,
            h_start=PHS.port_a_nominal.h,
            nPorts_b=3,
            showName=false)
            annotation (Placement(transformation(extent={{-2,-90},{-22,-70}})));
          Modelica.Blocks.Sources.Step Demand(
            height=25e06,
            offset=125e06,
            startTime=3000)
            annotation (Placement(transformation(extent={{98,-88},{118,-68}})));
        equation
          connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-36,
                  75.8},{-29,75.8},{-29,77.3333},{-22,77.3333}},
                                                      color={0,127,255}));
          connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-36,13.8},{-28,
                  13.8},{-28,78},{-22,78}}, color={0,127,255}));
          connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-36,
                  -48.2},{-30,-48.2},{-30,78.6667},{-22,78.6667}},
                                                       color={0,127,255}));
          connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-36,
                  54.2},{-28,54.2},{-28,-80.6667},{-18,-80.6667}},
                                                        color={0,127,255}));
          connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-36,-7.8},{-36,
                  -8},{-24,-8},{-24,-78},{-18,-78},{-18,-80}}, color={0,127,255}));
          connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-36,
                  -69.8},{-28,-69.8},{-28,-79.3333},{-18,-79.3333}},
                                                             color={0,127,255}));
          connect(volume.port_b[1], BOP.port_a) annotation (Line(points={{-10,78},{2,78},
                  {2,15},{10,15}}, color={0,127,255}));
          connect(volume1.port_a[1], BOP.port_b) annotation (Line(points={{-6,-80},{2,-80},
                  {2,-5},{10,-5}}, color={0,127,255}));
          connect(BOP.portElec_b, EG.portElec_a)
            annotation (Line(points={{60,5},{73,5},{73,5},{86,5}}, color={255,0,0}));
          annotation (
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{160,
                    100}})),
            experiment(
              StopTime=5000,
              __Dymola_NumberOfIntervals=2000,
              __Dymola_Algorithm="Esdirk45a"),
            __Dymola_experimentSetupOutput(events=false),
            Icon(coordinateSystem(extent={{-100,-100},{160,100}})));
        end Test_threeCoupledBOP_w_BOP_nSteadyControl;

        package Trial_Single_Test
          model Trial_Standalone
            extends Modelica.Icons.Example;

            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS
              annotation (Placement(transformation(extent={{-52,-36},{26,42}})));

            TRANSFORM.Fluid.BoundaryConditions.Boundary_pT sink(
              nPorts=1,
              p=PHS.port_b_nominal.p,
              T=PHS.port_b_nominal.T,
              redeclare package Medium = Modelica.Media.Water.StandardWater)
              annotation (Placement(transformation(extent={{76,30},{56,50}})));
            TRANSFORM.Fluid.BoundaryConditions.Boundary_pT      source(
              nPorts=1,
              T=PHS.port_a_nominal.T,
              redeclare package Medium = Modelica.Media.Water.StandardWater,
              p=PHS.port_a_nominal.p)
              annotation (Placement(transformation(extent={{74,-40},{54,-20}})));
          equation
            connect(sink.ports[1], PHS.port_b) annotation (Line(points={{56,40},
                    {46,40},{46,18.6},{26,18.6}},
                                      color={0,127,255}));
            connect(source.ports[1], PHS.port_a) annotation (Line(points={{54,-30},{46,
                    -30},{46,-12.6},{26,-12.6}},
                                             color={0,127,255}));
            annotation (
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                      100,100}})),
              experiment(
                StopTime=1000,
                __Dymola_NumberOfIntervals=1000,
                __Dymola_Algorithm="Esdirk45a"),
              __Dymola_experimentSetupOutput(events=false));
          end Trial_Standalone;

          model Trial_SingleCoupledBOP_wo_anyControls

            extends Modelica.Icons.Example;

            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS
              annotation (Placement(transformation(extent={{-154,-16},{-82,56}})));

            NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP( port_a_nominal(
                p=PHS.port_b_nominal.p,
                h=PHS.port_b_nominal.h,
                m_flow=-PHS.port_b_nominal.m_flow),
              port_b_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h))
              annotation (Placement(transformation(extent={{-44,-16},{28,56}})));
            NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG annotation (
                Placement(transformation(extent={{58,-14},{148,56}})));
          equation
            connect(PHS.port_b, BOP.port_a) annotation (Line(points={{-82,34.4},
                    {-44,34.4}},            color={0,127,255}));
            connect(PHS.port_a, BOP.port_b) annotation (Line(points={{-82,5.6},
                    {-44,5.6}},          color={0,127,255}));
            connect(BOP.portElec_b, EG.portElec_a) annotation (Line(points={{28,
                    20},{48,20},{48,21},{58,21}}, color={255,0,0}));
            annotation (
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,
                      -100},{180,80}})),
              experiment(
                StopTime=1000,
                __Dymola_NumberOfIntervals=1000,
                __Dymola_Algorithm="Esdirk45a"),
              __Dymola_experimentSetupOutput(events=false),
              Icon(coordinateSystem(extent={{-180,-100},{180,80}})));
          end Trial_SingleCoupledBOP_wo_anyControls;

          model Trial_SingleCoupledBOP_w_BOPcontrol

            extends Modelica.Icons.Example;

            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS
              annotation (Placement(transformation(extent={{-154,-16},{-82,56}})));

            NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP( port_a_nominal(
                p=PHS.port_b_nominal.p,
                h=PHS.port_b_nominal.h,
                m_flow=-PHS.port_b_nominal.m_flow),
              port_b_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
              redeclare
                NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
                CS(
                p_nominal=BOP.port_a_nominal.p,
                W_totalSetpoint=50e06,
                delayStartTCV=200))
              annotation (Placement(transformation(extent={{-44,-16},{28,56}})));
            NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG
              annotation (Placement(transformation(extent={{58,-16},{138,56}})));
          equation
            connect(PHS.port_b, BOP.port_a) annotation (Line(points={{-82,34.4},{-44,34.4}},
                                            color={0,127,255}));
            connect(PHS.port_a, BOP.port_b) annotation (Line(points={{-82,5.6},{-44,5.6}},
                                         color={0,127,255}));
            connect(BOP.portElec_b, EG.portElec_a) annotation (Line(points={{28,20},
                    {58,20}},         color={255,0,0}));
            annotation (
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{180,
                      80}})),
              experiment(
                StopTime=1000,
                __Dymola_NumberOfIntervals=1000,
                __Dymola_Algorithm="Esdirk45a"),
              __Dymola_experimentSetupOutput(events=false),
              Icon(coordinateSystem(extent={{-180,-100},{180,80}})));
          end Trial_SingleCoupledBOP_w_BOPcontrol;

          model Trial_SingleCoupledBOP_w_BOP_nSteady_control

            extends Modelica.Icons.Example;

            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(redeclare
                NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
              annotation (Placement(transformation(extent={{-154,-16},{-82,56}})));

            NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP( port_a_nominal(
                p=PHS.port_b_nominal.p,
                h=PHS.port_b_nominal.h,
                m_flow=-PHS.port_b_nominal.m_flow),
              port_b_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
              redeclare
                NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
                CS(
                p_nominal=BOP.port_a_nominal.p,
                W_totalSetpoint=50e06,
                delayStartTCV=200))
              annotation (Placement(transformation(extent={{-44,-16},{28,56}})));
            NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG
              annotation (Placement(transformation(extent={{58,-16},{138,56}})));
          equation
            connect(PHS.port_b, BOP.port_a) annotation (Line(points={{-82,34.4},{-44,34.4}},
                                            color={0,127,255}));
            connect(PHS.port_a, BOP.port_b) annotation (Line(points={{-82,5.6},{-44,5.6}},
                                         color={0,127,255}));
            connect(BOP.portElec_b, EG.portElec_a) annotation (Line(points={{28,20},{58,20}},
                                      color={255,0,0}));
            annotation (
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{180,
                      80}})),
              experiment(
                StopTime=1000,
                __Dymola_NumberOfIntervals=1000,
                __Dymola_Algorithm="Esdirk45a"),
              __Dymola_experimentSetupOutput(events=false),
              Icon(coordinateSystem(extent={{-180,-100},{180,80}})));
          end Trial_SingleCoupledBOP_w_BOP_nSteady_control;
        end Trial_Single_Test;

      end Generic_Modular;

      package Trial_SMR
        model Trial_Standalone
          extends Modelica.Icons.Example;

          NHES.Systems.PrimaryHeatSystem.SMR_Generic.Components.SMR_Tave_enthalpy
            nuScale_Tave_enthalpy(
            redeclare
              NHES.Systems.PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave_Enthalpy
              CS(
              T_SG_exit=579.15,
              Q_nom(displayUnit="MW") = 160000000,
              demand=1.0),
            port_a_nominal(
              m_flow=70,
              p=3447380,
              T(displayUnit="degC") = 421.15),
            port_b_nominal(
              p=3447380,
              T(displayUnit="degC") = 579.25,
              h=2997670))
            annotation (Placement(transformation(extent={{-76,-52},{20,64}})));
          Modelica.Fluid.Sources.Boundary_pT boundary2(
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            T(displayUnit="K") = 421.15,
            nPorts=1,
            p=3447380)
            annotation (Placement(transformation(extent={{76,-14},{52,10}})));
          Modelica.Fluid.Sources.Boundary_ph boundary3(
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            h=nuScale_Tave_enthalpy.port_b_nominal.h,
            nPorts=1,
            p=nuScale_Tave_enthalpy.port_b_nominal.p)
            annotation (Placement(transformation(extent={{76,20},{52,42}})));
        equation
          connect(boundary2.ports[1],nuScale_Tave_enthalpy. port_a) annotation (
              Line(points={{52,-2},{36,-2},{36,-1.13846},{21.7455,-1.13846}}, color=
                 {0,127,255}));
          connect(boundary3.ports[1],nuScale_Tave_enthalpy. port_b) annotation (
              Line(points={{52,31},{36,31},{36,28.3077},{21.7455,28.3077}}, color={
                  0,127,255}));
          annotation (
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},
                    {100,100}})),
            experiment(
              StopTime=1800,
              __Dymola_NumberOfIntervals=180,
              __Dymola_Algorithm="Esdirk45a"),
            __Dymola_experimentSetupOutput(events=false),
            Icon(coordinateSystem(extent={{-100,-80},{100,100}})));
        end Trial_Standalone;

        model Trial_threeCoupledBOP_wControls
          NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(port_a_nominal(
              p=sMR_Tave_enthalpy.port_b_nominal.p,
              h=sMR_Tave_enthalpy.port_b_nominal.h,
              m_flow=-sMR_Tave_enthalpy.port_b_nominal.m_flow - sMR_Tave_enthalpy1.port_b_nominal.m_flow - sMR_Tave_enthalpy2.port_b_nominal.m_flow),
            port_b_nominal(p=sMR_Tave_enthalpy.port_a_nominal.p, h=sMR_Tave_enthalpy.port_a_nominal.h),    redeclare
              NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
              CS(
              p_nominal=BOP.port_a_nominal.p,
              W_totalSetpoint=Demand.y,
              delayStartTCV=0))
            annotation (Placement(transformation(extent={{10,-20},{60,30}})));
          NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG
            annotation (Placement(transformation(extent={{86,-20},{138,30}})));
          TRANSFORM.Fluid.Volumes.MixingVolume volume(
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            use_T_start=false,
            redeclare model Geometry =
                TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
                (V=0.001),
            nPorts_b=1,
            p_start=sMR_Tave_enthalpy.port_b_nominal.p,
            h_start=sMR_Tave_enthalpy.port_b_nominal.h,
            showName=false,
            nPorts_a=3)
            annotation (Placement(transformation(extent={{-26,68},{-6,88}})));
          TRANSFORM.Fluid.Volumes.MixingVolume volume1(
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            use_T_start=false,
            redeclare model Geometry =
                TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
                (V=0.001),
            nPorts_a=1,
            p_start=sMR_Tave_enthalpy.port_a_nominal.p,
            h_start=sMR_Tave_enthalpy.port_a_nominal.h,
            showName=false,
            nPorts_b=3)
            annotation (Placement(transformation(extent={{-2,-90},{-22,-70}})));
          Modelica.Blocks.Sources.Step Demand(
            height=25e06,
            offset=125e06,
            startTime=3000)
            annotation (Placement(transformation(extent={{98,-88},{118,-68}})));
          NHES.Systems.PrimaryHeatSystem.SMR_Generic.Components.SMR_Tave_enthalpy
            sMR_Tave_enthalpy(redeclare NHES.Systems.PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave_Enthalpy CS(
              T_SG_exit=579.15,
              Q_nom(displayUnit="MW") = 160000000,
              demand=1.0),
            port_a_nominal(
              m_flow=70,
              p=3447380,
              T(displayUnit="degC") = 421.15),
            port_b_nominal(
              p=3447380,
              T(displayUnit="degC") = 579.25,
              h=2997670))
            annotation (Placement(transformation(extent={{-100,28},{-46,92}})));
          NHES.Systems.PrimaryHeatSystem.SMR_Generic.Components.SMR_Tave_enthalpy
            sMR_Tave_enthalpy1(redeclare NHES.Systems.PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave_Enthalpy CS(
              T_SG_exit=579.15,
              Q_nom(displayUnit="MW") = 160000000,
              demand=1.0),
            port_a_nominal(
              m_flow=70,
              p=3447380,
              T(displayUnit="degC") = 421.15),
            port_b_nominal(
              p=3447380,
              T(displayUnit="degC") = 579.25,
              h=2997670))
            annotation (Placement(transformation(extent={{-100,-36},{-46,28}})));
          NHES.Systems.PrimaryHeatSystem.SMR_Generic.Components.SMR_Tave_enthalpy
            sMR_Tave_enthalpy2(redeclare NHES.Systems.PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave_Enthalpy CS(
              T_SG_exit=579.15,
              Q_nom(displayUnit="MW") = 160000000,
              demand=1.0),
            port_a_nominal(
              m_flow=70,
              p=3447380,
              T(displayUnit="degC") = 421.15),
            port_b_nominal(
              p=3447380,
              T(displayUnit="degC") = 579.25,
              h=2997670))
            annotation (Placement(transformation(extent={{-98,-100},{-44,-36}})));
        equation
          connect(volume.port_b[1], BOP.port_a) annotation (Line(points={{-10,78},{2,78},
                  {2,15},{10,15}}, color={0,127,255}));
          connect(volume1.port_a[1], BOP.port_b) annotation (Line(points={{-6,-80},{2,-80},
                  {2,-5},{10,-5}}, color={0,127,255}));
          connect(BOP.portElec_b, EG.portElec_a)
            annotation (Line(points={{60,5},{73,5},{73,5},{86,5}}, color={255,0,0}));
          connect(sMR_Tave_enthalpy.port_b, volume.port_a[1]) annotation (Line(points={{
                  -45.0182,72.3077},{-44,72.3077},{-44,77.3333},{-22,77.3333}}, color={0,
                  127,255}));
          connect(sMR_Tave_enthalpy.port_a, volume1.port_b[1]) annotation (Line(points={{
                  -45.0182,56.0615},{-45.0182,56.0308},{-18,56.0308},{-18,
                  -80.6667}},
                color={0,127,255}));
          connect(sMR_Tave_enthalpy1.port_b, volume.port_a[2]) annotation (Line(points={{
                  -45.0182,8.30769},{-45.0182,52},{-22,52},{-22,78}},  color={0,127,255}));
          connect(sMR_Tave_enthalpy2.port_b, volume.port_a[3]) annotation (Line(points={{
                  -43.0182,-55.6923},{-44,-55.6923},{-44,-56},{-38,-56},{-38,64},
                  {-22,64},{-22,78.6667}},
                                  color={0,127,255}));
          connect(sMR_Tave_enthalpy1.port_a, volume1.port_b[2]) annotation (Line(points={{
                  -45.0182,-7.93846},{-45.0182,-10.9692},{-18,-10.9692},{-18,
                  -80}},
                color={0,127,255}));
          connect(sMR_Tave_enthalpy2.port_a, volume1.port_b[3]) annotation (Line(points={{
                  -43.0182,-71.9385},{-30.5091,-71.9385},{-30.5091,-79.3333},{
                  -18,-79.3333}},
                color={0,127,255}));
          annotation (
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{160,
                    100}})),
            experiment(
              StopTime=5000,
              __Dymola_NumberOfIntervals=2000,
              __Dymola_Algorithm="Esdirk45a"),
            __Dymola_experimentSetupOutput(events=false),
            Icon(coordinateSystem(extent={{-100,-100},{160,100}})));
        end Trial_threeCoupledBOP_wControls;
      end Trial_SMR;
    end SteadyState_Sim;

    package Trial_Loadfollow_Sim
      package Generic_Modular

        model Test_threeCoupledBOP_w_BOP_nLoadFollowControl
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(redeclare
              NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
            annotation (Placement(transformation(extent={{-90,38},{-36,92}})));
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(redeclare
              NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
            annotation (Placement(transformation(extent={{-90,-24},{-36,30}})));
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(redeclare
              NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
            annotation (Placement(transformation(extent={{-90,-86},{-36,-32}})));
          NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(port_a_nominal(
              p=PHS.port_b_nominal.p,
              h=PHS.port_b_nominal.h,
              m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
            port_b_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),    redeclare
              NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
              CS(
              p_nominal=BOP.port_a_nominal.p,
              W_totalSetpoint=Demand.y,
              delayStartTCV=0))
            annotation (Placement(transformation(extent={{10,-20},{60,30}})));
          NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG
            annotation (Placement(transformation(extent={{86,-20},{138,30}})));
          TRANSFORM.Fluid.Volumes.MixingVolume volume(
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            use_T_start=false,
            redeclare model Geometry =
                TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
                (V=0.001),
            nPorts_b=1,
            p_start=PHS.port_b_nominal.p,
            h_start=PHS.port_b_nominal.h,
            nPorts_a=3,
            showName=false)
            annotation (Placement(transformation(extent={{-26,68},{-6,88}})));
          TRANSFORM.Fluid.Volumes.MixingVolume volume1(
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            use_T_start=false,
            redeclare model Geometry =
                TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
                (V=0.001),
            nPorts_a=1,
            p_start=PHS.port_a_nominal.p,
            h_start=PHS.port_a_nominal.h,
            nPorts_b=3,
            showName=false)
            annotation (Placement(transformation(extent={{-2,-90},{-22,-70}})));
          Modelica.Blocks.Sources.Step Demand(
            height=25e06,
            offset=125e06,
            startTime=2500)
            annotation (Placement(transformation(extent={{98,-84},{118,-64}})));
        equation
          connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-36,
                  75.8},{-29,75.8},{-29,77.3333},{-22,77.3333}},
                                                      color={0,127,255}));
          connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-36,13.8},{-28,
                  13.8},{-28,78},{-22,78}}, color={0,127,255}));
          connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-36,
                  -48.2},{-30,-48.2},{-30,78.6667},{-22,78.6667}},
                                                       color={0,127,255}));
          connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-36,
                  54.2},{-28,54.2},{-28,-80.6667},{-18,-80.6667}},
                                                        color={0,127,255}));
          connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-36,-7.8},{-36,
                  -8},{-24,-8},{-24,-78},{-18,-78},{-18,-80}}, color={0,127,255}));
          connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-36,
                  -69.8},{-28,-69.8},{-28,-79.3333},{-18,-79.3333}},
                                                             color={0,127,255}));
          connect(volume.port_b[1], BOP.port_a) annotation (Line(points={{-10,78},{2,78},
                  {2,15},{10,15}}, color={0,127,255}));
          connect(volume1.port_a[1], BOP.port_b) annotation (Line(points={{-6,-80},{2,-80},
                  {2,-5},{10,-5}}, color={0,127,255}));
          connect(BOP.portElec_b, EG.portElec_a)
            annotation (Line(points={{60,5},{73,5},{73,5},{86,5}}, color={255,0,0}));
          annotation (
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{160,
                    100}})),
            experiment(
              StopTime=5000,
              __Dymola_NumberOfIntervals=2000,
              __Dymola_Algorithm="Esdirk45a"),
            __Dymola_experimentSetupOutput(events=false),
            Icon(coordinateSystem(extent={{-100,-100},{160,100}})));
        end Test_threeCoupledBOP_w_BOP_nLoadFollowControl;
      end Generic_Modular;
    end Trial_Loadfollow_Sim;
  end ReactorBOP_Sim;

  package Components
    package HTSE
      package PowerControl
        model HTSEPowerCtrl_GenericModular_OldLoad
          extends
            NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_SubSystem_B(
            allowFlowReversal=system.allowFlowReversal,
            redeclare replaceable
              NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.CS_Dummy CS,
            redeclare replaceable
              NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.ED_Dummy ED,
            port_a_nominal(
              p=3.5e6,
              T=573.369,
              m_flow=9.0942),
            port_b_nominal(p=3.9e6, T=473.119),
            redeclare
              NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Data.TightlyCoupled
              data);

          parameter Integer numCells_perVessel = 68320
            "Total number of cells per vessel" annotation (Dialog(group="HTSE vessel(s) size"));
          parameter Integer numVessels = 5 "Number of online vessels per system" annotation (Dialog(group="HTSE vessel(s) size"));
          final parameter Real eta_powerCycle(min=0, max=1, unit="1") = 0.318 "Power cycle efficiency";

          Modelica.Units.SI.MassFlowRate mH2_sec
            "H2 produced during electrolysis per second";
          NHES.Electrolysis.Types.AnnualMassFlowRate mH2_yr
            "H2 produced during electrolysis per year";
          Modelica.Units.SI.MassFlowRate mO2_sec
            "O2 produced during electrolysis per second";
          NHES.Electrolysis.Types.AnnualMassFlowRate mO2_yr
            "O2 produced during electrolysis per year";

          Modelica.Units.SI.Power Q_nuclearHeatCathodeRecup
            "Nuclear heat transferred from the hot utility to cathode stream";
          Modelica.Units.SI.Power Q_nuclearHeatAnodeRecup
            "Nuclear heat transferred from the hot utility to anode stream";
          Modelica.Units.SI.Power Q_nuclearHeatRecup
            "Total nuclear heat transferred from the hot utility to the cathode and anode streams";
          Modelica.Units.SI.Power Wq_nuclearHeatRecup
            "Electrical power equivalent to 'Q_nuclearHeatRecup' with 'eta_powerCycle'";
          Modelica.Units.SI.Power W_total "Total energy consumption in the HTSE plant";
          Real We_HTSE_percent(min=0,max=100,unit="1",displayUnit="%") "Percentage of electrical energy consumption in the HTSE plant";
          Real Wq_HTSE_percent(min=0,max=100,unit="1",displayUnit="%") "Percentage of thermal energy consumption in the HTSE plant";

          inner Modelica.Fluid.System system(allowFlowReversal=false,
            T_ambient=298.15,
            m_flow_start=9.0942)
            annotation (Placement(transformation(extent={{140,80},{160,100}})));
          NHES.Electrolysis.HeatExchangers.HEX_nuclearHeatCathodeGasRecup_ROM_NHES hEX_nuclearHeatCathodeGasRecup_ROM(
            redeclare package Medium_tube = Modelica.Media.Water.StandardWater,
            redeclare package Medium_shell = Medium,
            initOpt=NHES.Electrolysis.Utilities.OptionsInit.noInit,
            TTube_out(start=283.4 + 273.15),
            hTube_out(start=2.98385e6, fixed=true),
            pTube_out(start=2045000))
            annotation (Placement(transformation(extent={{-68,-14},{-52,2}})));
          Modelica.Fluid.Sources.MassFlowSource_T feedCathodeGas(
            use_m_flow_in=true,
            m_flow=4.484668581,
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            nPorts=1,
            T=system.T_ambient)
            annotation (Placement(transformation(extent={{-106,-16},{-86,4}})));
          NHES.Electrolysis.Sensors.TempSensorWithThermowell TNOut_cathodeGasSensor(
            tau=13,
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            initType=Modelica.Blocks.Types.Init.InitialOutput,
            y_start=283.4 + 273.15)
            annotation (Placement(transformation(extent={{-50,8},{-30,28}})));
          NHES.Electrolysis.Fittings.CascadeCtrlIdeal_yH2 cascadeCtrl_yH2(
            redeclare package MixtureGas =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            redeclare package Steam = Modelica.Media.Water.StandardWater,
            allowFlowReversal=false,
            yH2_setPoint=0.1,
            V=0.125,
            initType_FBctrl_yH2=Modelica.Blocks.Types.Init.SteadyState,
            TSteam_start=556.55)
            annotation (Placement(transformation(extent={{-22,0},{2,-24}})));
          NHES.Electrolysis.HeatExchangers.HEX_cathodeGasRecup_ROM hEX_cathodeGasRecup_ROM(
            redeclare package Medium_tube =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            redeclare package Medium_shell =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            shell_in(p(start=controlledSOEC.SOECstack.pstartCathodeAvg)),
            initOpt=NHES.Electrolysis.Utilities.OptionsInit.steadyState)
            annotation (Placement(transformation(extent={{18,-20},{34,-4}})));

          NHES.Electrolysis.Electrolyzers.ControlledSOEC_integratedWithHTSEplant_updateLogTerm
            controlledSOEC(
            initOpt=NHES.Electrolysis.Utilities.OptionsInit.userSpecified,
            FBctrl_SUfactor(x(start=controlledSOEC.wCathode_in_start/controlledSOEC.FBctrl_SUfactor.k,
                  fixed=true)),
            FBctrl_TC_out(y(start=controlledSOEC.wAnode_in_start)),
            numCells_perVessel=numCells_perVessel,
            numVessels=numVessels,
            FBctrl_SUfactor_T=5,
            FBctrl_SUfactor_k=0.1,
            FBctrl_TC_out_T=18,
            FBctrl_TC_out_k=0.008,
            initType_wCathode_in=Modelica.Blocks.Types.Init.SteadyState,
            initType_wAnode_in=Modelica.Blocks.Types.Init.InitialOutput)
            annotation (Placement(transformation(extent={{98,-76},{132,-42}})));
          NHES.Electrolysis.ElectricHeaters.ToppingHeater_cathodeGas_elecPort toppingHeater_cathodeGas(
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            isCircular=true,
            initType=Modelica.Blocks.Types.Init.InitialOutput,
            TC_set(displayUnit="degC") = 1123.15)
            annotation (Placement(transformation(extent={{52,-20},{68,-4}})));

          NHES.Electrolysis.Sensors.TempSensorWithThermowell TCtopping_out(
            initType=Modelica.Blocks.Types.Init.SteadyState,
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            y_start=850 + 273.15,
            tau=13) annotation (Placement(transformation(extent={{70,-4},{90,16}})));

          NHES.Electrolysis.HeatExchangers.HEX_nuclearHeatAnodeGasRecup_ROM_NHES hEX_nuclearHeatAnodeGasRecup_ROM(
            redeclare package Medium_tube =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            AhShell=hEX_nuclearHeatAnodeGasRecup_ROM.AhTube*1.35,
            redeclare package Medium_shell = Medium,
            initOpt=NHES.Electrolysis.Utilities.OptionsInit.noInit,
            pShell_out(start=4317930),
            TTube_out(start=532.15, fixed=true),
            TShell_out(start=465.838))
            annotation (Placement(transformation(extent={{-68,-104},{-52,-120}})));
          Modelica.Fluid.Sources.MassFlowSource_T feedAnodeGas(
            use_m_flow_in=true,
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            nPorts=1,
            X=NHES.Electrolysis.Utilities.moleToMassFractions(
                                                         {0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
                *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*
                1000}),
            m_flow=23.27935,
            T=system.T_ambient)
                        annotation (Placement(transformation(extent={{-106,-122},{-86,
                    -102}})));
          NHES.Electrolysis.Sensors.TempSensorWithThermowell TNOut_anodeGasSensor(
            initType=Modelica.Blocks.Types.Init.SteadyState,
            tau=13,
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            y_start=259 + 273.15)
            annotation (Placement(transformation(extent={{-50,-124},{-30,-144}})));
          NHES.Electrolysis.HeatExchangers.HEX_anodeGasRecup_ROM_NHES hEX_anodeGasRecup_ROM(
            redeclare package Medium_tube =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            redeclare package Medium_shell =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            initOpt=NHES.Electrolysis.Utilities.OptionsInit.noInit)
            annotation (Placement(transformation(extent={{18,-104},{34,-120}})));
          Modelica.Fluid.Sources.Boundary_pT wAnodeShell_sink(
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            nPorts=1,
            p=1923000,
            T=605.838) annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={26,-78})));

          NHES.Electrolysis.ElectricHeaters.ToppingHeater_anodeGas_elecPort toppingHeater_anodeGas(
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            isCircular=true,
            initType=Modelica.Blocks.Types.Init.InitialOutput,
            TA_set=1123.15)
            annotation (Placement(transformation(extent={{52,-104},{68,-120}})));
          NHES.Electrolysis.Sensors.TempSensorWithThermowell TAtopping_out(
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=850 + 273.15,
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            tau=13) annotation (Placement(transformation(extent={{70,-120},{90,-140}})));
          Modelica.Blocks.Continuous.FirstOrder actuator_wAnode_in(
            k=1,
            y_start=controlledSOEC.FBctrl_TC_out.y_start,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            T=8)  annotation (Placement(transformation(
                extent={{8,-8},{-8,8}},
                rotation=0,
                origin={-40,-194})));
          Modelica.Blocks.Continuous.FirstOrder actuator_wCathode_in(
            k=1,
            y_start=controlledSOEC.FBctrl_SUfactor.y_start,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            T=36)                                              annotation (
              Placement(transformation(
                extent={{8,-8},{-8,8}},
                rotation=0,
                origin={-40,76})));
          Modelica.Fluid.Valves.ValveLinear TCV_cathodeGas(
            allowFlowReversal=false,
            m_flow_small=0.001,
            show_T=true,
            redeclare package Medium = Medium,
            m_flow_start=6.47972,
            m_flow_nominal=6.47972,
            dp_nominal=0.5*((58 - 44.0804)*1e5),
            dp_start=(58 - 44.0804)*1e5,
            m_flow(start=6.47972))
                         annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-90,30})));
          Modelica.Fluid.Valves.ValveLinear TCV_anodeGas(
            allowFlowReversal=false,
            m_flow_small=0.001,
            m_flow_nominal=2.61448,
            show_T=true,
            m_flow_start=2.61448,
            dp_nominal=0.5*((58 - 43.5)*1e5),
            redeclare package Medium = Medium,
            dp_start=(58 - 43.5)*1e5,
            m_flow(start=2.61448, fixed=true))
                                  annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-90,-140})));
          Modelica.Fluid.Fittings.TeeJunctionIdeal flowSplit(
                               redeclare package Medium = Medium, port_2(p(start=5800000,
                  fixed=true)))                            annotation (Placement(
                transformation(
                extent={{10,-10},{-10,10}},
                rotation=0,
                origin={-126,-50})));
          Modelica.Fluid.Fittings.TeeJunctionIdeal flowJoin(redeclare package
              Medium =
                Medium)                             annotation (Placement(
                transformation(
                extent={{10,10},{-10,-10}},
                rotation=0,
                origin={-74,-78})));

          NHES.Electrolysis.Sensors.PowerSensor W_HTSE annotation (Placement(
                transformation(
                extent={{8,-8},{-8,8}},
                rotation=90,
                origin={148,0})));
          Modelica.Blocks.Sources.RealExpression mH2(y=mH2_sec)
            annotation (Placement(transformation(extent={{-130,78},{-150,98}})));
          Modelica.Blocks.Sources.RealExpression mO2(y=mO2_sec)
            annotation (Placement(transformation(extent={{-130,64},{-150,84}})));
          Modelica.Fluid.Sensors.Pressure pH2O_in(redeclare package Medium =
                Modelica.Media.Water.StandardWater)
            annotation (Placement(transformation(extent={{-132,48},{-148,64}})));
          Modelica.Fluid.Sensors.Temperature TH2O_in(redeclare package Medium =
                Modelica.Media.Water.StandardWater)
            annotation (Placement(transformation(extent={{-142,30},{-158,46}})));
          Modelica.Fluid.Sensors.MassFlowRate mH2O_in(redeclare package Medium =
                Modelica.Media.Water.StandardWater) annotation (Placement(
                transformation(
                extent={{8,-8},{-8,8}},
                rotation=90,
                origin={-140,-26})));
          Modelica.Fluid.Sensors.MassFlowRate mH2O_out(redeclare package Medium =
                Modelica.Media.Water.StandardWater) annotation (Placement(
                transformation(
                extent={{-8,8},{8,-8}},
                rotation=270,
                origin={-134,-120})));
          Modelica.Fluid.Sensors.Temperature TH2O_out(redeclare package Medium =
                Modelica.Media.Water.StandardWater)
            annotation (Placement(transformation(extent={{-142,-104},{-158,-88}})));
          Modelica.Fluid.Sensors.Pressure pH2O_out(redeclare package Medium =
                Modelica.Media.Water.StandardWater)
            annotation (Placement(transformation(extent={{-136,-74},{-152,-58}})));
          Modelica.Fluid.Sources.Boundary_pT H2_sink(
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            nPorts=1,
            p=1960350,
            T=618.331) annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-40,-46})));
          NHES.Electrolysis.Fittings.IdealRecycle_H2 idealRecycle_H2(redeclare
              package Medium =
                       NHES.Electrolysis.Media.Electrolysis.CathodeGas)
            annotation (Placement(transformation(extent={{-22,-52},{2,-28}})));
          NHES.Electrolysis.Separator.Temp_flashDrum flashDrum(redeclare
              package Medium =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas) annotation (Placement(
                transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={26,-40})));
          Modelica.Fluid.Sources.Boundary_pT H2O_sink(
            nPorts=1,
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            p=1960350,
            T=618.331) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={60,-40})));
          Modelica.Blocks.Sources.Ramp TNOut_anodeGas_set(
            offset=259 + 273.15,
            startTime=100,
            height=0,
            duration=0,
            y(displayUnit="degC", unit="K"))
                          annotation (Placement(transformation(
                extent={{-8,8},{8,-8}},
                rotation=180,
                origin={-12,-164})));
          Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_anodeGas(
            k=1,
            T=4,
            y_start=0.5,
            initType=Modelica.Blocks.Types.Init.SteadyState)
                 annotation (Placement(transformation(
                extent={{8,-8},{-8,8}},
                rotation=0,
                origin={-70,-164})));
          Modelica.Blocks.Continuous.LimPID FBctrl_TNOut_anodeGas(
            controllerType=Modelica.Blocks.Types.SimpleController.PI,
            yMin=0.05,
            gainPID(y(start=0.5)),
            y(start=0.5),
            xi_start=0.5/FBctrl_TNOut_anodeGas.k,
            y_start=0.5,
            yMax=5,
            k=0.0008*0 + (1/223.36)*5,
            Ti=10*0 + 47.1571789477849,
            initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(
                transformation(
                extent={{8,8},{-8,-8}},
                rotation=0,
                origin={-40,-164})));
          Modelica.Blocks.Sources.Constant valveOpening_cathodeGas(k=0.5)  annotation (
              Placement(transformation(
                extent={{8,-8},{-8,8}},
                rotation=0,
                origin={-72,52})));
          NHES.Electrolysis.Electrical.SwitchYard switchYard(powerConsumption_SOEC(
                fixed=true))
            annotation (Placement(transformation(extent={{50,-88},{70,-68}})));
          NHES.Electrolysis.Sensors.PowerSensor W_SOEC annotation (Placement(
                transformation(
                extent={{-8,-8},{8,8}},
                rotation=90,
                origin={86,-76})));
          NHES.Electrolysis.HTSE.Intermediate_HTSE.IdealPump returnPump(
            redeclare package Medium = Medium,
            PR0=60.9167/43.1691*0 + 59.02/43.1793,
            pstart_out=5902000,
            Tstart=488.787)
            annotation (Placement(transformation(extent={{-92,-86},{-108,-70}})));
          NHES.Electrical.Load load_IP(Wn=0, fn=60) annotation (Placement(
                transformation(
                extent={{-14,-14},{14,14}},
                rotation=180,
                origin={140,-38})));
          NHES.Electrical.Sources.PowerSource W_IP(use_W_in=true, W=51.1454e6)
            annotation (Placement(transformation(
                extent={{-6,6},{6,-6}},
                rotation=270,
                origin={148,26})));
        equation
          mH2_sec = hEX_cathodeGasRecup_ROM.wShell_out*hEX_cathodeGasRecup_ROM.XShell_out[1] - cascadeCtrl_yH2.mixtureGas_port_1.m_flow;
          mH2_yr =  mH2_sec*60*60*24*365;
          mO2_sec = controlledSOEC.SOECstack.deltaM_O2*controlledSOEC.numVessels;
          mO2_yr = mO2_sec*60*60*24*365;

          Q_nuclearHeatCathodeRecup = hEX_nuclearHeatCathodeGasRecup_ROM.QTube_gained;
          Q_nuclearHeatAnodeRecup = hEX_nuclearHeatAnodeGasRecup_ROM.QTube_gained;
          Q_nuclearHeatRecup = Q_nuclearHeatCathodeRecup + Q_nuclearHeatAnodeRecup;
          Wq_nuclearHeatRecup = Q_nuclearHeatRecup*eta_powerCycle;

          W_total =switchYard.totalElec_sink.W + Wq_nuclearHeatRecup;

          We_HTSE_percent =(switchYard.totalElec_sink.W/W_total)*100;
          Wq_HTSE_percent = (Wq_nuclearHeatRecup/W_total)*100;

          connect(toppingHeater_cathodeGas.port_a,hEX_cathodeGasRecup_ROM. tube_out)
            annotation (Line(points={{52,-12},{52,-12},{34,-12}},
                                                               color={0,127,255}));
          connect(controlledSOEC.ctrlCathodeOut,hEX_cathodeGasRecup_ROM. shell_in)
            annotation (Line(points={{127.58,-50.5},{134,-50.5},{134,30},{26,30},{26,-4}},
                        color={0,127,255}));
          connect(toppingHeater_cathodeGas.s_TC_in,TCtopping_out. y) annotation (Line(
                points={{60,-3.2},{60,20},{80,20},{80,15}}, color={0,0,127}));
          connect(cascadeCtrl_yH2.mixtureGas_port_3,hEX_cathodeGasRecup_ROM. tube_in)
            annotation (Line(points={{-0.4,-12},{8,-12},{18,-12}},
                                                          color={0,127,255}));
          connect(hEX_nuclearHeatCathodeGasRecup_ROM.tube_out,cascadeCtrl_yH2. steam_port_2)
            annotation (Line(points={{-52,-6},{-52,-6},{-19.6,-6}},
                                                           color={0,127,255}));
          connect(TNOut_cathodeGasSensor.port,cascadeCtrl_yH2. steam_port_2)
            annotation (Line(points={{-40,8},{-40,-6},{-19.6,-6}},  color={0,0,127}));
          connect(feedCathodeGas.ports[1],hEX_nuclearHeatCathodeGasRecup_ROM. tube_in)
            annotation (Line(points={{-86,-6},{-86,-6},{-68,-6}},
                                                         color={0,127,255}));
          connect(feedAnodeGas.ports[1],hEX_nuclearHeatAnodeGasRecup_ROM. tube_in)
            annotation (Line(points={{-86,-112},{-86,-112},{-68,-112}},
                                                               color={0,127,255}));
          connect(hEX_nuclearHeatAnodeGasRecup_ROM.tube_out,hEX_anodeGasRecup_ROM.
                                  tube_in) annotation (Line(points={{-52,-112},{-52,
                  -112},{18,-112}},
                                  color={0,127,255}));
          connect(hEX_anodeGasRecup_ROM.tube_out,toppingHeater_anodeGas. port_a)
            annotation (Line(points={{34,-112},{34,-112},{52,-112}},
                                                                  color={0,127,255}));
          connect(TAtopping_out.y,toppingHeater_anodeGas. s_TA_in) annotation (Line(
                points={{80,-139},{80,-144},{60,-144},{60,-120.8}},
                                                                color={0,0,127}));
          connect(wAnodeShell_sink.ports[1], hEX_anodeGasRecup_ROM.shell_out)
            annotation (Line(points={{26,-88},{26,-104}},color={0,127,255}));
          connect(TNOut_anodeGasSensor.port,hEX_anodeGasRecup_ROM. tube_in) annotation (
             Line(points={{-40,-124},{-40,-112},{18,-112}},
                                                         color={0,0,127}));
          connect(controlledSOEC.ctrlAnodeOut,hEX_anodeGasRecup_ROM. shell_in)
            annotation (Line(points={{127.58,-64.78},{134,-64.78},{134,-150},{26,-150},
                  {26,-120}},color={0,127,255}));
          connect(controlledSOEC.c_wAnodeIn,actuator_wAnode_in. u) annotation (
              Line(points={{113.64,-71.58},{113.64,-194},{-30.4,-194}},color={0,0,
                  127}));
          connect(actuator_wAnode_in.y,feedAnodeGas. m_flow_in) annotation (Line(
                points={{-48.8,-194},{-116,-194},{-116,-104},{-106,-104}},
                                                                        color={0,
                  0,127}));
          connect(controlledSOEC.c_wCathode,actuator_wCathode_in. u) annotation (
              Line(points={{115,-48.8},{115,76},{-30.4,76}}, color={0,0,127}));
          connect(actuator_wCathode_in.y,feedCathodeGas. m_flow_in) annotation (
              Line(points={{-48.8,76},{-116,76},{-116,2},{-106,2}},   color={0,0,
                  127}));
          connect(TCV_cathodeGas.port_b, hEX_nuclearHeatCathodeGasRecup_ROM.shell_in)
            annotation (Line(points={{-80,30},{-60,30},{-60,2}},  color={0,127,255}));
          connect(hEX_nuclearHeatAnodeGasRecup_ROM.shell_in, TCV_anodeGas.port_b)
            annotation (Line(points={{-60,-120},{-60,-140},{-80,-140}},
                                                                     color={0,127,
                  255}));
          connect(flowSplit.port_3, TCV_cathodeGas.port_a) annotation (Line(points={{-126,
                  -40},{-126,30},{-100,30}},       color={0,127,255}));
          connect(flowSplit.port_1, TCV_anodeGas.port_a) annotation (Line(points={{-116,
                  -50},{-112,-50},{-112,-140},{-100,-140}},  color={0,127,255}));
          connect(TCtopping_out.port, toppingHeater_cathodeGas.port_b)
            annotation (Line(points={{80,-4},{80,-12},{68,-12}},
                                                               color={0,0,127}));
          connect(TAtopping_out.port, toppingHeater_anodeGas.port_b) annotation (
              Line(points={{80,-120},{80,-112},{68,-112}},
                                                        color={0,0,127}));
          connect(controlledSOEC.ctrlAnodeIn, toppingHeater_anodeGas.port_b)
            annotation (Line(points={{102.42,-68.18},{96,-68.18},{96,-112},{68,-112}},
                color={0,127,255}));
          connect(controlledSOEC.ctrlCathodeIn, toppingHeater_cathodeGas.port_b)
            annotation (Line(points={{102.42,-53.9},{96,-53.9},{96,-12},{68,-12}},
                                                                             color=
                  {0,127,255}));
          connect(mH2O_in.port_b, flowSplit.port_2) annotation (Line(points={{-140,-34},
                  {-140,-50},{-136,-50}},   color={0,127,255}));
          connect(mH2O_in.port_a, port_a) annotation (Line(points={{-140,-18},{-140,20},
                  {-200,20}},     color={0,127,255}));
          connect(mH2O_in.port_a, TH2O_in.port) annotation (Line(points={{-140,-18},{
                  -140,26},{-150,26},{-150,30}},  color={0,0,127}));
          connect(pH2O_in.port, TH2O_in.port) annotation (Line(points={{-140,48},{-140,
                  26},{-150,26},{-150,30}},      color={0,0,127}));
          connect(pH2O_out.port, TH2O_out.port) annotation (Line(points={{-144,-74},{
                  -144,-104},{-150,-104}}, color={0,0,127}));
          connect(flowJoin.port_3, hEX_nuclearHeatAnodeGasRecup_ROM.shell_out)
            annotation (Line(points={{-74,-88},{-74,-94},{-60,-94},{-60,-104}},
                color={0,127,255}));
          connect(hEX_cathodeGasRecup_ROM.shell_out, flashDrum.feedInlet)
            annotation (Line(points={{26,-20},{26,-26},{26,-32}},
                                                               color={0,127,255}));
          connect(H2O_sink.ports[1], flashDrum.liquidOutlet)
            annotation (Line(points={{50,-40},{35,-40}},       color={0,127,255}));
          connect(flashDrum.vaporOutlet, idealRecycle_H2.H2_feed) annotation (Line(
                points={{17,-40},{-0.4,-40}},         color={0,127,255}));
          connect(cascadeCtrl_yH2.c_yH2, idealRecycle_H2.c_yH2) annotation (Line(
                points={{-5.2,-15.36},{-5.2,-26},{-5.2,-37.36}},        color={0,0,
                  127}));
          connect(H2_sink.ports[1], idealRecycle_H2.H2_prod) annotation (Line(
                points={{-30,-46},{-19.6,-46}},          color={0,127,255}));
          connect(idealRecycle_H2.H2_recycle, cascadeCtrl_yH2.mixtureGas_port_1)
            annotation (Line(points={{-19.6,-34},{-26,-34},{-26,-18},{-19.6,-18}},
                color={0,127,255}));
          connect(actuator_TNOut_anodeGas.u,FBctrl_TNOut_anodeGas. y) annotation (
              Line(points={{-60.4,-164},{-48.8,-164}},                       color=
                  {0,0,127}));
          connect(FBctrl_TNOut_anodeGas.u_s,TNOut_anodeGas_set. y) annotation (Line(
                points={{-30.4,-164},{-30.4,-164},{-20.8,-164}},
                                                               color={0,0,127}));
          connect(TNOut_anodeGasSensor.y, FBctrl_TNOut_anodeGas.u_m)
            annotation (Line(points={{-40,-143},{-40,-154.4}},
                                                             color={0,0,127}));
          connect(actuator_TNOut_anodeGas.y, TCV_anodeGas.opening) annotation (Line(
                points={{-78.8,-164},{-90,-164},{-90,-148}},color={0,0,127}));
          connect(valveOpening_cathodeGas.y, TCV_cathodeGas.opening) annotation (Line(
                points={{-80.8,52},{-90,52},{-90,38}},   color={0,0,127}));
          connect(switchYard.totalElecPower, W_HTSE.port_b) annotation (Line(
              points={{68,-70},{80,-70},{80,-26},{148,-26},{148,-8}},
              color={255,0,0},
              thickness=0.5));
          connect(toppingHeater_cathodeGas.loadElecHeater, switchYard.load_catElecHeater)
            annotation (Line(points={{60,-20},{60,-26},{74,-26},{74,-60},{52,-60},{52,
                  -70}},
                color={255,0,0},thickness=0.5));
          connect(toppingHeater_anodeGas.loadElecHeater, switchYard.load_anElecHeater)
            annotation (Line(points={{60,-104},{60,-94},{52,-94},{52,-86}},color={
                  255,0,0},thickness=0.5));
          connect(switchYard.load_SOEC, W_SOEC.port_a) annotation (Line(
              points={{68,-86},{86,-86},{86,-84}},
              color={255,0,0},
              thickness=0.5));
          connect(W_SOEC.port_b, controlledSOEC.ctrlElectricalLoad) annotation (Line(
              points={{86,-68},{86,-68},{86,-60.7},{102.08,-60.7}},
              color={255,0,0},
              thickness=0.5));
          connect(hEX_nuclearHeatCathodeGasRecup_ROM.shell_out, flowJoin.port_1)
            annotation (Line(points={{-60,-14},{-60,-14},{-60,-78},{-64,-78}},
                                                                             color={0,127,
                  255}));
          connect(returnPump.inlet, flowJoin.port_2) annotation (Line(points={{-92,-78},
                  {-88,-78},{-84,-78}}, color={0,127,255}));
          connect(sensorBus.TNOut_cathodeGas, TNOut_cathodeGasSensor.y)
            annotation (Line(
              points={{-29.9,100.1},{0,100.1},{0,40},{-40,40},{-40,27}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.T_out, TH2O_out.T) annotation (Line(
              points={{-29.9,100.1},{-160,100.1},{-160,-96},{-155.6,-96}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.m_flow_out, mH2O_out.m_flow) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,-120},{-142.8,-120}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));

          connect(sensorBus.p_out, pH2O_out.p) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,-66},{-152.8,-66}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.m_flow_in, mH2O_in.m_flow) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,-26},{-148.8,-26}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.T_in, TH2O_in.T) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,38},{-155.6,38}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.p_in, pH2O_in.p) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,56},{-148.8,56}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));

          connect(sensorBus.m_flow_O2_prod, mO2.y) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,74},{-151,74}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.m_flow_H2_prod, mH2.y) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,88},{-151,88}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.W_SOEC, W_SOEC.W) annotation (Line(
              points={{-29.9,100.1},{160,100.1},{160,-76},{93.52,-76}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.W_HTSE, W_HTSE.W) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{160,100.1},{160,0},{155.52,0}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(W_HTSE.port_a, W_IP.portElec_a) annotation (Line(
              points={{148,8},{148,14},{148,20}},
              color={255,0,0},
              thickness=0.5));
          connect(actuatorBus.subBus_IP.HTSE.W_IP, load_IP.powerConsumption) annotation (
              Line(
              points={{30,100},{30,104},{164,104},{164,-38},{144.62,-38}},
              color={111,216,99},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(actuatorBus.subBus_IP.HTSE.W_IP, W_IP.W_in) annotation (Line(
              points={{30,100},{30,100},{30,100},{30,104},{164,104},{164,40},{148,40},{148,
                  33.2}},
              color={111,216,99},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(port_b, mH2O_out.port_b) annotation (Line(points={{-200,-140},{-200,
                  -140},{-134,-140},{-134,-128}}, color={0,127,255}));
          connect(returnPump.outlet, mH2O_out.port_a) annotation (Line(points={{-108,
                  -78},{-134,-78},{-134,-112}}, color={0,127,255}));
          connect(pH2O_out.port, returnPump.outlet) annotation (Line(points={{-144,-74},
                  {-144,-78},{-108,-78}}, color={0,127,255}));
          connect(load_IP.portElec_a, portElec_a) annotation (Line(points={{140,-49.2},
                  {140,-60},{200,-60}}, color={255,0,0}));
          annotation (defaultComponentName="IP",
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-220},{200,
                    140}})),            Icon(coordinateSystem(preserveAspectRatio=false,
                           extent={{-100,-100},{100,100}}), graphics={Bitmap(extent={{
                      -72,-56},{74,26}},
                  imageSource=
                      "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"
                       +
                      "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"
                       +
                      "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"
                       +
                      "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",
                  fileName=
                      "modelica://NHES/../Resources/Images/Systems/IP/Electrolysis/HTSE.png"),
                          Text(
                  extent={{-94,76},{94,68}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,237},
                  fillPattern=FillPattern.Solid,
                  textString="High-Temperature
Steam Electrolysis")}));
        end HTSEPowerCtrl_GenericModular_OldLoad;

        model HTSEPowerCtrl_GenericModular
          extends
            NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_SubSystem_B(
            allowFlowReversal=system.allowFlowReversal,
            redeclare replaceable
              NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.CS_Dummy CS,
            redeclare replaceable
              NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.ED_Dummy ED,
            port_a_nominal(
              p=3.5e6,
              T=573.369,
              m_flow=9.0942),
            port_b_nominal(p=3.9e6, T=473.119),
            redeclare
              NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Data.TightlyCoupled
              data);

          parameter Integer numCells_perVessel = 68320
            "Total number of cells per vessel" annotation (Dialog(group="HTSE vessel(s) size"));
          parameter Integer numVessels = 5 "Number of online vessels per system" annotation (Dialog(group="HTSE vessel(s) size"));
          final parameter Real eta_powerCycle(min=0, max=1, unit="1") = 0.318 "Power cycle efficiency";

          Modelica.Units.SI.MassFlowRate mH2_sec
            "H2 produced during electrolysis per second";
          NHES.Electrolysis.Types.AnnualMassFlowRate mH2_yr
            "H2 produced during electrolysis per year";
          Modelica.Units.SI.MassFlowRate mO2_sec
            "O2 produced during electrolysis per second";
          NHES.Electrolysis.Types.AnnualMassFlowRate mO2_yr
            "O2 produced during electrolysis per year";

          Modelica.Units.SI.Power Q_nuclearHeatCathodeRecup
            "Nuclear heat transferred from the hot utility to cathode stream";
          Modelica.Units.SI.Power Q_nuclearHeatAnodeRecup
            "Nuclear heat transferred from the hot utility to anode stream";
          Modelica.Units.SI.Power Q_nuclearHeatRecup
            "Total nuclear heat transferred from the hot utility to the cathode and anode streams";
          Modelica.Units.SI.Power Wq_nuclearHeatRecup
            "Electrical power equivalent to 'Q_nuclearHeatRecup' with 'eta_powerCycle'";
          Modelica.Units.SI.Power W_total "Total energy consumption in the HTSE plant";
          Real We_HTSE_percent(min=0,max=100,unit="1",displayUnit="%") "Percentage of electrical energy consumption in the HTSE plant";
          Real Wq_HTSE_percent(min=0,max=100,unit="1",displayUnit="%") "Percentage of thermal energy consumption in the HTSE plant";

          inner Modelica.Fluid.System system(allowFlowReversal=false,
            T_ambient=298.15,
            m_flow_start=9.0942)
            annotation (Placement(transformation(extent={{140,80},{160,100}})));
          NHES.Electrolysis.HeatExchangers.HEX_nuclearHeatCathodeGasRecup_ROM_NHES hEX_nuclearHeatCathodeGasRecup_ROM(
            redeclare package Medium_tube = Modelica.Media.Water.StandardWater,
            redeclare package Medium_shell = Medium,
            initOpt=NHES.Electrolysis.Utilities.OptionsInit.noInit,
            TTube_out(start=556.55),
            hTube_out(start=2.98385e6, fixed=true),
            pTube_out(start=2045000))
            annotation (Placement(transformation(extent={{-68,-14},{-52,2}})));
          Modelica.Fluid.Sources.MassFlowSource_T feedCathodeGas(
            use_m_flow_in=true,
            m_flow=4.484668581,
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            nPorts=1,
            T=system.T_ambient)
            annotation (Placement(transformation(extent={{-106,-16},{-86,4}})));
          NHES.Electrolysis.Sensors.TempSensorWithThermowell TNOut_cathodeGasSensor(
            tau=13,
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            initType=Modelica.Blocks.Types.Init.InitialOutput,
            y_start=283.4 + 273.15)
            annotation (Placement(transformation(extent={{-50,8},{-30,28}})));
          NHES.Electrolysis.Fittings.CascadeCtrlIdeal_yH2 cascadeCtrl_yH2(
            redeclare package MixtureGas =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            redeclare package Steam = Modelica.Media.Water.StandardWater,
            allowFlowReversal=false,
            yH2_setPoint=0.1,
            V=0.125,
            initType_FBctrl_yH2=Modelica.Blocks.Types.Init.SteadyState,
            TSteam_start=556.55)
            annotation (Placement(transformation(extent={{-22,0},{2,-24}})));
          NHES.Electrolysis.HeatExchangers.HEX_cathodeGasRecup_ROM hEX_cathodeGasRecup_ROM(
            redeclare package Medium_tube =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            redeclare package Medium_shell =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            shell_in(p(start=controlledSOEC.SOECstack.pstartCathodeAvg)),
            initOpt=NHES.Electrolysis.Utilities.OptionsInit.steadyState)
            annotation (Placement(transformation(extent={{18,-20},{34,-4}})));

          NHES.Electrolysis.Electrolyzers.ControlledSOEC_integratedWithHTSEplant_updateLogTerm
            controlledSOEC(
            initOpt=NHES.Electrolysis.Utilities.OptionsInit.userSpecified,
            FBctrl_SUfactor(x(start=controlledSOEC.wCathode_in_start/controlledSOEC.FBctrl_SUfactor.k,
                  fixed=true)),
            FBctrl_TC_out(y(start=controlledSOEC.wAnode_in_start)),
            numCells_perVessel=numCells_perVessel,
            numVessels=numVessels,
            FBctrl_SUfactor_T=5,
            FBctrl_SUfactor_k=0.1,
            FBctrl_TC_out_T=18,
            FBctrl_TC_out_k=0.008,
            initType_wCathode_in=Modelica.Blocks.Types.Init.SteadyState,
            initType_wAnode_in=Modelica.Blocks.Types.Init.InitialOutput)
            annotation (Placement(transformation(extent={{98,-76},{132,-42}})));
          NHES.Electrolysis.ElectricHeaters.ToppingHeater_cathodeGas_elecPort toppingHeater_cathodeGas(
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            isCircular=true,
            initType=Modelica.Blocks.Types.Init.InitialOutput,
            TC_set(displayUnit="degC") = 1123.15)
            annotation (Placement(transformation(extent={{52,-20},{68,-4}})));

          NHES.Electrolysis.Sensors.TempSensorWithThermowell TCtopping_out(
            initType=Modelica.Blocks.Types.Init.SteadyState,
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            y_start=850 + 273.15,
            tau=13) annotation (Placement(transformation(extent={{70,-4},{90,16}})));

          NHES.Electrolysis.HeatExchangers.HEX_nuclearHeatAnodeGasRecup_ROM_NHES hEX_nuclearHeatAnodeGasRecup_ROM(
            redeclare package Medium_tube =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            AhShell=hEX_nuclearHeatAnodeGasRecup_ROM.AhTube*1.35,
            redeclare package Medium_shell = Medium,
            initOpt=NHES.Electrolysis.Utilities.OptionsInit.noInit,
            pShell_out(start=4317930),
            TTube_out(start=532.15, fixed=true),
            TShell_out(start=465.838))
            annotation (Placement(transformation(extent={{-68,-104},{-52,-120}})));
          Modelica.Fluid.Sources.MassFlowSource_T feedAnodeGas(
            use_m_flow_in=true,
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            nPorts=1,
            X=NHES.Electrolysis.Utilities.moleToMassFractions(
                                                         {0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
                *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*
                1000}),
            m_flow=23.27935,
            T=system.T_ambient)
                        annotation (Placement(transformation(extent={{-106,-122},{-86,
                    -102}})));
          NHES.Electrolysis.Sensors.TempSensorWithThermowell TNOut_anodeGasSensor(
            initType=Modelica.Blocks.Types.Init.SteadyState,
            tau=13,
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            y_start=259 + 273.15)
            annotation (Placement(transformation(extent={{-50,-126},{-30,-146}})));
          NHES.Electrolysis.HeatExchangers.HEX_anodeGasRecup_ROM_NHES hEX_anodeGasRecup_ROM(
            redeclare package Medium_tube =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            redeclare package Medium_shell =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            initOpt=NHES.Electrolysis.Utilities.OptionsInit.noInit)
            annotation (Placement(transformation(extent={{18,-104},{34,-120}})));
          Modelica.Fluid.Sources.Boundary_pT wAnodeShell_sink(
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            nPorts=1,
            p=1923000,
            T=605.838) annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={26,-78})));

          NHES.Electrolysis.ElectricHeaters.ToppingHeater_anodeGas_elecPort toppingHeater_anodeGas(
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            isCircular=true,
            initType=Modelica.Blocks.Types.Init.InitialOutput,
            TA_set=1123.15)
            annotation (Placement(transformation(extent={{52,-104},{68,-120}})));
          NHES.Electrolysis.Sensors.TempSensorWithThermowell TAtopping_out(
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=850 + 273.15,
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            tau=13) annotation (Placement(transformation(extent={{70,-120},{90,-140}})));
          Modelica.Blocks.Continuous.FirstOrder actuator_wAnode_in(
            k=1,
            y_start=controlledSOEC.FBctrl_TC_out.y_start,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            T=8)  annotation (Placement(transformation(
                extent={{8,-8},{-8,8}},
                rotation=0,
                origin={-40,-194})));
          Modelica.Blocks.Continuous.FirstOrder actuator_wCathode_in(
            k=1,
            y_start=controlledSOEC.FBctrl_SUfactor.y_start,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            T=36)                                              annotation (
              Placement(transformation(
                extent={{8,-8},{-8,8}},
                rotation=0,
                origin={-40,76})));
          Modelica.Fluid.Valves.ValveLinear TCV_cathodeGas(
            allowFlowReversal=false,
            m_flow_small=0.001,
            show_T=true,
            redeclare package Medium = Medium,
            m_flow_start=6.47972,
            m_flow_nominal=6.47972,
            dp_nominal=0.5*((58 - 44.0804)*1e5),
            dp_start=(58 - 44.0804)*1e5,
            m_flow(start=6.47972))
                         annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-90,30})));
          Modelica.Fluid.Valves.ValveLinear TCV_anodeGas(
            allowFlowReversal=false,
            m_flow_small=0.001,
            m_flow_nominal=2.61448,
            show_T=true,
            m_flow_start=2.61448,
            dp_nominal=0.5*((58 - 43.5)*1e5),
            redeclare package Medium = Medium,
            dp_start=(58 - 43.5)*1e5,
            m_flow(start=2.61448, fixed=true))
                                  annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-90,-140})));
          Modelica.Fluid.Fittings.TeeJunctionIdeal flowSplit(
                               redeclare package Medium = Medium, port_2(p(start=5800000,
                  fixed=true)))                            annotation (Placement(
                transformation(
                extent={{10,-10},{-10,10}},
                rotation=0,
                origin={-126,-50})));
          Modelica.Fluid.Fittings.TeeJunctionIdeal flowJoin(redeclare package
              Medium =
                Medium)                             annotation (Placement(
                transformation(
                extent={{10,10},{-10,-10}},
                rotation=0,
                origin={-74,-78})));

          NHES.Electrolysis.Sensors.PowerSensor W_HTSE annotation (Placement(
                transformation(
                extent={{8,-8},{-8,8}},
                rotation=90,
                origin={148,0})));
          Modelica.Blocks.Sources.RealExpression mH2(y=mH2_sec)
            annotation (Placement(transformation(extent={{-130,78},{-150,98}})));
          Modelica.Blocks.Sources.RealExpression mO2(y=mO2_sec)
            annotation (Placement(transformation(extent={{-130,64},{-150,84}})));
          Modelica.Fluid.Sensors.Pressure pH2O_in(redeclare package Medium =
                Modelica.Media.Water.StandardWater)
            annotation (Placement(transformation(extent={{-132,48},{-148,64}})));
          Modelica.Fluid.Sensors.Temperature TH2O_in(redeclare package Medium =
                Modelica.Media.Water.StandardWater)
            annotation (Placement(transformation(extent={{-142,30},{-158,46}})));
          Modelica.Fluid.Sensors.MassFlowRate mH2O_in(redeclare package Medium =
                Modelica.Media.Water.StandardWater) annotation (Placement(
                transformation(
                extent={{8,-8},{-8,8}},
                rotation=90,
                origin={-140,-26})));
          Modelica.Fluid.Sensors.MassFlowRate mH2O_out(redeclare package Medium =
                Modelica.Media.Water.StandardWater) annotation (Placement(
                transformation(
                extent={{-8,8},{8,-8}},
                rotation=270,
                origin={-134,-120})));
          Modelica.Fluid.Sensors.Temperature TH2O_out(redeclare package Medium =
                Modelica.Media.Water.StandardWater)
            annotation (Placement(transformation(extent={{-142,-104},{-158,-88}})));
          Modelica.Fluid.Sensors.Pressure pH2O_out(redeclare package Medium =
                Modelica.Media.Water.StandardWater)
            annotation (Placement(transformation(extent={{-136,-74},{-152,-58}})));
          Modelica.Fluid.Sources.Boundary_pT H2_sink(
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            nPorts=1,
            p=1960350,
            T=618.331) annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-40,-46})));
          NHES.Electrolysis.Fittings.IdealRecycle_H2 idealRecycle_H2(redeclare
              package Medium =
                       NHES.Electrolysis.Media.Electrolysis.CathodeGas)
            annotation (Placement(transformation(extent={{-22,-52},{2,-28}})));
          NHES.Electrolysis.Separator.Temp_flashDrum flashDrum(redeclare
              package Medium =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas) annotation (Placement(
                transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={26,-40})));
          Modelica.Fluid.Sources.Boundary_pT H2O_sink(
            nPorts=1,
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            p=1960350,
            T=618.331) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={60,-40})));
          Modelica.Blocks.Sources.Ramp TNOut_anodeGas_set(
            offset=259 + 273.15,
            startTime=100,
            height=0,
            duration=0,
            y(displayUnit="degC", unit="K"))
                          annotation (Placement(transformation(
                extent={{-8,8},{8,-8}},
                rotation=180,
                origin={-12,-164})));
          Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_anodeGas(
            k=1,
            T=4,
            y_start=0.5,
            initType=Modelica.Blocks.Types.Init.SteadyState)
                 annotation (Placement(transformation(
                extent={{8,-8},{-8,8}},
                rotation=0,
                origin={-70,-164})));
          Modelica.Blocks.Continuous.LimPID FBctrl_TNOut_anodeGas(
            controllerType=Modelica.Blocks.Types.SimpleController.PI,
            yMin=0.05,
            gainPID(y(start=0.5)),
            y(start=0.5),
            xi_start=0.5/FBctrl_TNOut_anodeGas.k,
            y_start=0.5,
            yMax=5,
            k=0.0008*0 + (1/223.36)*5,
            Ti=10*0 + 47.1571789477849,
            initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(
                transformation(
                extent={{8,8},{-8,-8}},
                rotation=0,
                origin={-40,-164})));
          Modelica.Blocks.Sources.Constant valveOpening_cathodeGas(k=0.5)  annotation (
              Placement(transformation(
                extent={{8,-8},{-8,8}},
                rotation=0,
                origin={-72,52})));
          NHES.Electrolysis.Electrical.SwitchYard switchYard(powerConsumption_SOEC(
                fixed=true))
            annotation (Placement(transformation(extent={{50,-88},{70,-68}})));
          NHES.Electrolysis.Sensors.PowerSensor W_SOEC annotation (Placement(
                transformation(
                extent={{-8,-8},{8,8}},
                rotation=90,
                origin={86,-76})));
          NHES.Electrolysis.HTSE.Intermediate_HTSE.IdealPump returnPump(
            redeclare package Medium = Medium,
            PR0=60.9167/43.1691*0 + 59.02/43.1793,
            pstart_out=5902000,
            Tstart=488.787)
            annotation (Placement(transformation(extent={{-92,-86},{-108,-70}})));

          Journal_IES_Simulations.Components.HTSE.LoadModified load_IP(Wn=0, fn=
               60) annotation (Placement(transformation(
                extent={{-14,-14},{14,14}},
                rotation=180,
                origin={140,-38})));
          NHES.Electrical.Sources.PowerSource W_IP(use_W_in=true, W=51.1454e6)
            annotation (Placement(transformation(
                extent={{-6,6},{6,-6}},
                rotation=270,
                origin={148,26})));
        equation
          mH2_sec = hEX_cathodeGasRecup_ROM.wShell_out*hEX_cathodeGasRecup_ROM.XShell_out[1] - cascadeCtrl_yH2.mixtureGas_port_1.m_flow;
          mH2_yr =  mH2_sec*60*60*24*365;
          mO2_sec = controlledSOEC.SOECstack.deltaM_O2*controlledSOEC.numVessels;
          mO2_yr = mO2_sec*60*60*24*365;

          Q_nuclearHeatCathodeRecup = hEX_nuclearHeatCathodeGasRecup_ROM.QTube_gained;
          Q_nuclearHeatAnodeRecup = hEX_nuclearHeatAnodeGasRecup_ROM.QTube_gained;
          Q_nuclearHeatRecup = Q_nuclearHeatCathodeRecup + Q_nuclearHeatAnodeRecup;
          Wq_nuclearHeatRecup = Q_nuclearHeatRecup*eta_powerCycle;

          W_total =switchYard.totalElec_sink.W + Wq_nuclearHeatRecup;

          We_HTSE_percent =(switchYard.totalElec_sink.W/W_total)*100;
          Wq_HTSE_percent = (Wq_nuclearHeatRecup/W_total)*100;

          connect(toppingHeater_cathodeGas.port_a,hEX_cathodeGasRecup_ROM. tube_out)
            annotation (Line(points={{52,-12},{52,-12},{34,-12}},
                                                               color={0,127,255}));
          connect(controlledSOEC.ctrlCathodeOut,hEX_cathodeGasRecup_ROM. shell_in)
            annotation (Line(points={{127.58,-50.5},{134,-50.5},{134,30},{26,30},{26,-4}},
                        color={0,127,255}));
          connect(toppingHeater_cathodeGas.s_TC_in,TCtopping_out. y) annotation (Line(
                points={{60,-3.2},{60,20},{80,20},{80,15}}, color={0,0,127}));
          connect(cascadeCtrl_yH2.mixtureGas_port_3,hEX_cathodeGasRecup_ROM. tube_in)
            annotation (Line(points={{-0.4,-12},{8,-12},{18,-12}},
                                                          color={0,127,255}));
          connect(hEX_nuclearHeatCathodeGasRecup_ROM.tube_out,cascadeCtrl_yH2. steam_port_2)
            annotation (Line(points={{-52,-6},{-52,-6},{-19.6,-6}},
                                                           color={0,127,255}));
          connect(TNOut_cathodeGasSensor.port,cascadeCtrl_yH2. steam_port_2)
            annotation (Line(points={{-40,8},{-40,-6},{-19.6,-6}},  color={0,0,127}));
          connect(feedCathodeGas.ports[1],hEX_nuclearHeatCathodeGasRecup_ROM. tube_in)
            annotation (Line(points={{-86,-6},{-86,-6},{-68,-6}},
                                                         color={0,127,255}));
          connect(feedAnodeGas.ports[1],hEX_nuclearHeatAnodeGasRecup_ROM. tube_in)
            annotation (Line(points={{-86,-112},{-86,-112},{-68,-112}},
                                                               color={0,127,255}));
          connect(hEX_nuclearHeatAnodeGasRecup_ROM.tube_out,hEX_anodeGasRecup_ROM.
                                  tube_in) annotation (Line(points={{-52,-112},{-52,
                  -112},{18,-112}},
                                  color={0,127,255}));
          connect(hEX_anodeGasRecup_ROM.tube_out,toppingHeater_anodeGas. port_a)
            annotation (Line(points={{34,-112},{34,-112},{52,-112}},
                                                                  color={0,127,255}));
          connect(TAtopping_out.y,toppingHeater_anodeGas. s_TA_in) annotation (Line(
                points={{80,-139},{80,-144},{60,-144},{60,-120.8}},
                                                                color={0,0,127}));
          connect(wAnodeShell_sink.ports[1], hEX_anodeGasRecup_ROM.shell_out)
            annotation (Line(points={{26,-88},{26,-104}},color={0,127,255}));
          connect(TNOut_anodeGasSensor.port,hEX_anodeGasRecup_ROM. tube_in) annotation (
             Line(points={{-40,-126},{-40,-112},{18,-112}},
                                                         color={0,0,127}));
          connect(controlledSOEC.ctrlAnodeOut,hEX_anodeGasRecup_ROM. shell_in)
            annotation (Line(points={{127.58,-64.78},{134,-64.78},{134,-150},{26,-150},
                  {26,-120}},color={0,127,255}));
          connect(controlledSOEC.c_wAnodeIn,actuator_wAnode_in. u) annotation (
              Line(points={{113.64,-71.58},{113.64,-194},{-30.4,-194}},color={0,0,
                  127}));
          connect(actuator_wAnode_in.y,feedAnodeGas. m_flow_in) annotation (Line(
                points={{-48.8,-194},{-116,-194},{-116,-104},{-106,-104}},
                                                                        color={0,
                  0,127}));
          connect(controlledSOEC.c_wCathode,actuator_wCathode_in. u) annotation (
              Line(points={{115,-48.8},{115,76},{-30.4,76}}, color={0,0,127}));
          connect(actuator_wCathode_in.y,feedCathodeGas. m_flow_in) annotation (
              Line(points={{-48.8,76},{-116,76},{-116,2},{-106,2}},   color={0,0,
                  127}));
          connect(TCV_cathodeGas.port_b, hEX_nuclearHeatCathodeGasRecup_ROM.shell_in)
            annotation (Line(points={{-80,30},{-60,30},{-60,2}},  color={0,127,255}));
          connect(hEX_nuclearHeatAnodeGasRecup_ROM.shell_in, TCV_anodeGas.port_b)
            annotation (Line(points={{-60,-120},{-60,-140},{-80,-140}},
                                                                     color={0,127,
                  255}));
          connect(flowSplit.port_3, TCV_cathodeGas.port_a) annotation (Line(points={{-126,
                  -40},{-126,30},{-100,30}},       color={0,127,255}));
          connect(flowSplit.port_1, TCV_anodeGas.port_a) annotation (Line(points={{-116,
                  -50},{-112,-50},{-112,-140},{-100,-140}},  color={0,127,255}));
          connect(TCtopping_out.port, toppingHeater_cathodeGas.port_b)
            annotation (Line(points={{80,-4},{80,-12},{68,-12}},
                                                               color={0,0,127}));
          connect(TAtopping_out.port, toppingHeater_anodeGas.port_b) annotation (
              Line(points={{80,-120},{80,-112},{68,-112}},
                                                        color={0,0,127}));
          connect(controlledSOEC.ctrlAnodeIn, toppingHeater_anodeGas.port_b)
            annotation (Line(points={{102.42,-68.18},{96,-68.18},{96,-112},{68,-112}},
                color={0,127,255}));
          connect(controlledSOEC.ctrlCathodeIn, toppingHeater_cathodeGas.port_b)
            annotation (Line(points={{102.42,-53.9},{96,-53.9},{96,-12},{68,-12}},
                                                                             color=
                  {0,127,255}));
          connect(mH2O_in.port_b, flowSplit.port_2) annotation (Line(points={{-140,-34},
                  {-140,-50},{-136,-50}},   color={0,127,255}));
          connect(mH2O_in.port_a, port_a) annotation (Line(points={{-140,-18},{-140,20},
                  {-200,20}},     color={0,127,255}));
          connect(mH2O_in.port_a, TH2O_in.port) annotation (Line(points={{-140,-18},{
                  -140,26},{-150,26},{-150,30}},  color={0,0,127}));
          connect(pH2O_in.port, TH2O_in.port) annotation (Line(points={{-140,48},{-140,
                  26},{-150,26},{-150,30}},      color={0,0,127}));
          connect(pH2O_out.port, TH2O_out.port) annotation (Line(points={{-144,-74},{
                  -144,-104},{-150,-104}}, color={0,0,127}));
          connect(flowJoin.port_3, hEX_nuclearHeatAnodeGasRecup_ROM.shell_out)
            annotation (Line(points={{-74,-88},{-74,-94},{-60,-94},{-60,-104}},
                color={0,127,255}));
          connect(hEX_cathodeGasRecup_ROM.shell_out, flashDrum.feedInlet)
            annotation (Line(points={{26,-20},{26,-26},{26,-32}},
                                                               color={0,127,255}));
          connect(H2O_sink.ports[1], flashDrum.liquidOutlet)
            annotation (Line(points={{50,-40},{35,-40}},       color={0,127,255}));
          connect(flashDrum.vaporOutlet, idealRecycle_H2.H2_feed) annotation (Line(
                points={{17,-40},{-0.4,-40}},         color={0,127,255}));
          connect(cascadeCtrl_yH2.c_yH2, idealRecycle_H2.c_yH2) annotation (Line(
                points={{-5.2,-15.36},{-5.2,-26},{-5.2,-37.36}},        color={0,0,
                  127}));
          connect(H2_sink.ports[1], idealRecycle_H2.H2_prod) annotation (Line(
                points={{-30,-46},{-19.6,-46}},          color={0,127,255}));
          connect(idealRecycle_H2.H2_recycle, cascadeCtrl_yH2.mixtureGas_port_1)
            annotation (Line(points={{-19.6,-34},{-26,-34},{-26,-18},{-19.6,-18}},
                color={0,127,255}));
          connect(actuator_TNOut_anodeGas.u,FBctrl_TNOut_anodeGas. y) annotation (
              Line(points={{-60.4,-164},{-48.8,-164}},                       color=
                  {0,0,127}));
          connect(FBctrl_TNOut_anodeGas.u_s,TNOut_anodeGas_set. y) annotation (Line(
                points={{-30.4,-164},{-30.4,-164},{-20.8,-164}},
                                                               color={0,0,127}));
          connect(TNOut_anodeGasSensor.y, FBctrl_TNOut_anodeGas.u_m)
            annotation (Line(points={{-40,-145},{-40,-154.4}},
                                                             color={0,0,127}));
          connect(actuator_TNOut_anodeGas.y, TCV_anodeGas.opening) annotation (Line(
                points={{-78.8,-164},{-90,-164},{-90,-148}},color={0,0,127}));
          connect(valveOpening_cathodeGas.y, TCV_cathodeGas.opening) annotation (Line(
                points={{-80.8,52},{-90,52},{-90,38}},   color={0,0,127}));
          connect(switchYard.totalElecPower, W_HTSE.port_b) annotation (Line(
              points={{68,-70},{80,-70},{80,-26},{148,-26},{148,-8}},
              color={255,0,0},
              thickness=0.5));
          connect(toppingHeater_cathodeGas.loadElecHeater, switchYard.load_catElecHeater)
            annotation (Line(points={{60,-20},{60,-26},{74,-26},{74,-60},{52,-60},{52,
                  -70}},
                color={255,0,0},thickness=0.5));
          connect(toppingHeater_anodeGas.loadElecHeater, switchYard.load_anElecHeater)
            annotation (Line(points={{60,-104},{60,-94},{52,-94},{52,-86}},color={
                  255,0,0},thickness=0.5));
          connect(switchYard.load_SOEC, W_SOEC.port_a) annotation (Line(
              points={{68,-86},{86,-86},{86,-84}},
              color={255,0,0},
              thickness=0.5));
          connect(W_SOEC.port_b, controlledSOEC.ctrlElectricalLoad) annotation (Line(
              points={{86,-68},{86,-68},{86,-60.7},{102.08,-60.7}},
              color={255,0,0},
              thickness=0.5));
          connect(hEX_nuclearHeatCathodeGasRecup_ROM.shell_out, flowJoin.port_1)
            annotation (Line(points={{-60,-14},{-60,-78},{-64,-78}},         color={0,127,
                  255}));
          connect(returnPump.inlet, flowJoin.port_2) annotation (Line(points={{-92,-78},
                  {-84,-78}},           color={0,127,255}));
          connect(sensorBus.TNOut_cathodeGas, TNOut_cathodeGasSensor.y)
            annotation (Line(
              points={{-29.9,100.1},{0,100.1},{0,40},{-40,40},{-40,27}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.T_out, TH2O_out.T) annotation (Line(
              points={{-29.9,100.1},{-160,100.1},{-160,-96},{-155.6,-96}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.m_flow_out, mH2O_out.m_flow) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,-120},{-142.8,-120}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));

          connect(sensorBus.p_out, pH2O_out.p) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,-66},{-152.8,-66}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.m_flow_in, mH2O_in.m_flow) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,-26},{-148.8,-26}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.T_in, TH2O_in.T) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,38},{-155.6,38}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.p_in, pH2O_in.p) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,56},{-148.8,56}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));

          connect(sensorBus.m_flow_O2_prod, mO2.y) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,74},{-151,74}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.m_flow_H2_prod, mH2.y) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,88},{-151,88}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.W_SOEC, W_SOEC.W) annotation (Line(
              points={{-29.9,100.1},{160,100.1},{160,-76},{93.52,-76}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.W_HTSE, W_HTSE.W) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{160,100.1},{160,0},{155.52,0}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(W_HTSE.port_a, W_IP.portElec_a) annotation (Line(
              points={{148,8},{148,14},{148,20}},
              color={255,0,0},
              thickness=0.5));
          connect(actuatorBus.subBus_IP.HTSE.W_IP, load_IP.powerConsumption) annotation (
              Line(
              points={{30,100},{30,104},{164,104},{164,-38},{144.62,-38}},
              color={111,216,99},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(actuatorBus.subBus_IP.HTSE.W_IP, W_IP.W_in) annotation (Line(
              points={{30,100},{30,100},{30,100},{30,104},{164,104},{164,40},{148,40},{148,
                  33.2}},
              color={111,216,99},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(port_b, mH2O_out.port_b) annotation (Line(points={{-200,-140},{-200,
                  -140},{-134,-140},{-134,-128}}, color={0,127,255}));
          connect(returnPump.outlet, mH2O_out.port_a) annotation (Line(points={{-108,
                  -78},{-134,-78},{-134,-112}}, color={0,127,255}));
          connect(pH2O_out.port, returnPump.outlet) annotation (Line(points={{-144,
                  -74},{-144,-78},{-108,-78}},
                                          color={0,127,255}));
          connect(load_IP.portElec_a, portElec_a) annotation (Line(points={{140,-49.2},
                  {140,-60},{200,-60}}, color={255,0,0}));
          annotation (defaultComponentName="IP",
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-220},{200,
                    140}})),            Icon(coordinateSystem(preserveAspectRatio=false,
                           extent={{-100,-100},{100,100}}), graphics={Bitmap(extent={{
                      -72,-56},{74,26}},
                  imageSource=
                      "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"
                       +
                      "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"
                       +
                      "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"
                       +
                      "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",
                  fileName=
                      "modelica://NHES/../Resources/Images/Systems/IP/Electrolysis/HTSE.png"),
                          Text(
                  extent={{-94,76},{94,68}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,237},
                  fillPattern=FillPattern.Solid,
                  textString="High-Temperature
Steam Electrolysis")}));
        end HTSEPowerCtrl_GenericModular;

        model CS_TightlyCoupled_PowerCtrl
          extends
            NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_ControlSystem;

          parameter Modelica.Units.SI.Power W_IP_nom(displayUnit="MW")=51.1454e6
            "Nominal electrical power consumption in the IP";
          final parameter Modelica.Units.SI.Power W_IP_max(displayUnit="MW")=
            W_IP_nom*1.05 "Maximum electrical power consumption in the IP";
          parameter Modelica.Units.SI.Power W_IP_min(displayUnit="MW")=20.9561e6
            "Minimum electrical power consumption in the IP";
        Modelica.Blocks.Math.Feedback feedback_TNOut_cathodeGas annotation (Placement(
                transformation(
                extent={{12,-12},{-12,12}},
                rotation=180,
                origin={-40,0})));
          Modelica.Blocks.Sources.Ramp TNOut_cathodeGas_set(
            startTime=100,
            height=0,
            duration=0,
            offset=283.4 + 273.15,
            y(displayUnit="degC", unit="K")) annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-70,30})));
          Modelica.Blocks.Continuous.PI FBctrl_TNOut_cathodeGas(
            k=8000,
            T=8,
            y(start=51.1454e6),
            initType=Modelica.Blocks.Types.Init.InitialState,
            x_start=FBctrl_TNOut_cathodeGas.y_start/FBctrl_TNOut_cathodeGas.k,
            y_start=51.1454e6)
            annotation (Placement(transformation(extent={{0,-10},{20,10}})));
          Modelica.Blocks.Nonlinear.Limiter limiter_W_IP(uMax=W_IP_max, uMin=W_IP_min)
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={50,0})));
        equation
          connect(feedback_TNOut_cathodeGas.y, FBctrl_TNOut_cathodeGas.u) annotation (
              Line(points={{-29.2,-1.33227e-015},{-29.2,0},{-2,0}}, color={0,0,127}));
          connect(FBctrl_TNOut_cathodeGas.y, limiter_W_IP.u) annotation (Line(points={{21,
                  0},{21,1.55431e-015},{38,1.55431e-015}}, color={0,0,127}));

          connect(TNOut_cathodeGas_set.y, feedback_TNOut_cathodeGas.u2)
            annotation (Line(points={{-59,30},{-40,30},{-40,9.6}}, color={0,0,127}));
          connect(sensorBus.TNOut_cathodeGas, feedback_TNOut_cathodeGas.u1)
            annotation (Line(
              points={{-29.9,-99.9},{-100,-99.9},{-100,0},{-49.6,0}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(actuatorBus.subBus_IP.HTSE.W_IP, limiter_W_IP.y) annotation (Line(
              points={{30,-100},{100,-100},{100,0},{61,0}},
              color={111,216,99},
              pattern=LinePattern.Dash,
              thickness=0.5));
        annotation(defaultComponentName="CS");
        end CS_TightlyCoupled_PowerCtrl;
      end PowerControl;

      package SteamControl
        model HTSESteamFlowCtrl_GenericModular
          extends
            NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_SubSystem_B(
            allowFlowReversal=system.allowFlowReversal,
            redeclare replaceable
              NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.CS_Dummy CS,
            redeclare replaceable
              NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.ED_Dummy ED,
            port_a_nominal(
              p=3.5e6,
              T=573.369,
              m_flow=9.0942),
            port_b_nominal(p=3.9e6, T=473.119),
            redeclare
              NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Data.TightlyCoupled
              data);

          final parameter Integer numCells_perVessel = 68320
            "Total number of cells per vessel" annotation (Dialog(group="HTSE vessel(s) size"));
          final parameter Integer numVessels = 5 "Number of online vessels per system" annotation (Dialog(group="HTSE vessel(s) size"));
          final parameter Real eta_powerCycle(min=0, max=1, unit="1") = 0.318 "Power cycle efficiency";
          final parameter Modelica.Units.SI.Power capacity_nom(displayUnit="MW")=51.1454e6
            "Nominal electrical power consumption during electrolysis";
          parameter Modelica.Units.SI.Power capacity(displayUnit="MW")=capacity_nom
            "System capacity";
          final parameter Real capacityScaler = capacity/capacity_nom "Scaler that sizes the capacity of the overall system";
          final parameter Real capacityScaler_minThreshhold = 0.9 "Minimum threshhold of a capacity scaler, above which the system is stable";
          final parameter Real capacityScaler_maxThreshhold = 2   "Maximum threshhold of a capacity scaler, below which the system is stable";
          final parameter Real capacityScaler_steamFlow = if capacityScaler < capacityScaler_minThreshhold then capacityScaler_minThreshhold elseif capacityScaler > capacityScaler_maxThreshhold then capacityScaler_maxThreshhold else capacityScaler "Scaler that sizes the steam flow rate";

          Modelica.Units.SI.MassFlowRate mH2_sec
            "H2 produced during electrolysis per second";
          NHES.Electrolysis.Types.AnnualMassFlowRate mH2_yr
            "H2 produced during electrolysis per year";
          Modelica.Units.SI.MassFlowRate mO2_sec
            "O2 produced during electrolysis per second";
          NHES.Electrolysis.Types.AnnualMassFlowRate mO2_yr
            "O2 produced during electrolysis per year";

          Modelica.Units.SI.Power Q_nuclearHeatCathodeRecup
            "Nuclear heat transferred from the hot utility to cathode stream";
          Modelica.Units.SI.Power Q_nuclearHeatAnodeRecup
            "Nuclear heat transferred from the hot utility to anode stream";
          Modelica.Units.SI.Power Q_nuclearHeatRecup
            "Total nuclear heat transferred from the hot utility to the cathode and anode streams";
          Modelica.Units.SI.Power Wq_nuclearHeatRecup
            "Electrical power equivalent to 'Q_nuclearHeatRecup' with 'eta_powerCycle'";
          Modelica.Units.SI.Power W_total "Total energy consumption in the HTSE plant";
          Real We_HTSE_percent(min=0,max=100,unit="1",displayUnit="%") "Percentage of electrical energy consumption in the HTSE plant";
          Real Wq_HTSE_percent(min=0,max=100,unit="1",displayUnit="%") "Percentage of thermal energy consumption in the HTSE plant";

          inner Modelica.Fluid.System system(allowFlowReversal=false,
            T_ambient=298.15,
            m_flow_start=9.0942)
            annotation (Placement(transformation(extent={{140,80},{160,100}})));
          NHES.Electrolysis.HeatExchangers.HEX_nuclearHeatCathodeGasRecup_ROM_NHES hEX_nuclearHeatCathodeGasRecup_ROM(
            redeclare package Medium_tube = Modelica.Media.Water.StandardWater,
            redeclare package Medium_shell = Medium,
            initOpt=NHES.Electrolysis.Utilities.OptionsInit.noInit,
            hTube_out(start=2.98385e6, fixed=true),
            tube_out(h_outflow(start=2.98365e6)))
            annotation (Placement(transformation(extent={{-68,-14},{-52,2}})));
          Modelica.Fluid.Sources.MassFlowSource_T feedCathodeGas(
            use_m_flow_in=true,
            m_flow=4.484668581,
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            nPorts=1,
            T=system.T_ambient)
            annotation (Placement(transformation(extent={{-106,-16},{-86,4}})));
          NHES.Electrolysis.Sensors.TempSensorWithThermowell TNOut_cathodeGasSensor(
            initType=Modelica.Blocks.Types.Init.SteadyState,
            tau=13,
            redeclare package Medium = Modelica.Media.Water.StandardWater,
            y_start=283.4 + 273.15)
            annotation (Placement(transformation(extent={{-50,8},{-30,28}})));
          NHES.Electrolysis.Fittings.CascadeCtrlIdeal_yH2 cascadeCtrl_yH2(
            redeclare package MixtureGas =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            redeclare package Steam = Modelica.Media.Water.StandardWater,
            allowFlowReversal=false,
            yH2_setPoint=0.1,
            V=0.125,
            initType_FBctrl_yH2=Modelica.Blocks.Types.Init.SteadyState,
            TSteam_start=556.55)
            annotation (Placement(transformation(extent={{-22,0},{2,-24}})));
          Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_cathodeGas(
            k=1,
            T=4,
            initType=Modelica.Blocks.Types.Init.NoInit,
            y_start=0.85)                                            annotation (
              Placement(transformation(
                extent={{8,-8},{-8,8}},
                rotation=0,
                origin={-68,48})));
          NHES.Electrolysis.HeatExchangers.HEX_cathodeGasRecup_ROM hEX_cathodeGasRecup_ROM(
            redeclare package Medium_tube =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            redeclare package Medium_shell =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            initOpt=NHES.Electrolysis.Utilities.OptionsInit.steadyState,
            shell_in(p(start=controlledSOEC.SOECstack.pstartCathodeAvg)))
            annotation (Placement(transformation(extent={{18,-20},{34,-4}})));

          NHES.Electrolysis.Electrolyzers.ControlledSOEC_integratedWithHTSEplant_updateLogTerm
            controlledSOEC(
            initOpt=NHES.Electrolysis.Utilities.OptionsInit.userSpecified,
            FBctrl_SUfactor_k=0.03,
            FBctrl_SUfactor_T=18,
            FBctrl_TC_out_k=0.012,
            FBctrl_TC_out_T=16,
            FBctrl_SUfactor(x(start=controlledSOEC.wCathode_in_start/controlledSOEC.FBctrl_SUfactor.k,
                  fixed=true)),
            FBctrl_TC_out(y(start=controlledSOEC.wAnode_in_start)),
            initType_wAnode_in=Modelica.Blocks.Types.Init.InitialOutput,
            numCells_perVessel=numCells_perVessel,
            numVessels=numVessels,
            initType_wCathode_in=Modelica.Blocks.Types.Init.SteadyState)
            annotation (Placement(transformation(extent={{98,-76},{132,-42}})));
          NHES.Electrolysis.ElectricHeaters.ToppingHeater_cathodeGas_elecPort toppingHeater_cathodeGas(
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            isCircular=true,
            initType=Modelica.Blocks.Types.Init.InitialOutput,
            TC_set(displayUnit="degC") = 1123.15)
            annotation (Placement(transformation(extent={{52,-20},{68,-4}})));

          NHES.Electrolysis.Sensors.TempSensorWithThermowell TCtopping_out(
            initType=Modelica.Blocks.Types.Init.SteadyState,
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            y_start=850 + 273.15,
            tau=13) annotation (Placement(transformation(extent={{70,-4},{90,16}})));

          NHES.Electrolysis.HeatExchangers.HEX_nuclearHeatAnodeGasRecup_ROM_NHES hEX_nuclearHeatAnodeGasRecup_ROM(
            redeclare package Medium_tube =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            AhShell=hEX_nuclearHeatAnodeGasRecup_ROM.AhTube*1.35,
            redeclare package Medium_shell = Medium,
            tube_out(h_outflow(start=239500)),
            initOpt=NHES.Electrolysis.Utilities.OptionsInit.noInit,
            TTube_out(start=532.15, fixed=true))
            annotation (Placement(transformation(extent={{-68,-104},{-52,-120}})));
          Modelica.Fluid.Sources.MassFlowSource_T feedAnodeGas(
            use_m_flow_in=true,
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            nPorts=1,
            X=NHES.Electrolysis.Utilities.moleToMassFractions(
                                                         {0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
                *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*
                1000}),
            m_flow=23.27935,
            T=system.T_ambient)
                        annotation (Placement(transformation(extent={{-106,-122},{-86,
                    -102}})));
          NHES.Electrolysis.Sensors.TempSensorWithThermowell TNOut_anodeGasSensor(
            initType=Modelica.Blocks.Types.Init.SteadyState,
            tau=13,
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            y_start=259 + 273.15)
            annotation (Placement(transformation(extent={{-50,-124},{-30,-144}})));
          NHES.Electrolysis.HeatExchangers.HEX_anodeGasRecup_ROM_NHES hEX_anodeGasRecup_ROM(
            redeclare package Medium_tube =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            redeclare package Medium_shell =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            initOpt=NHES.Electrolysis.Utilities.OptionsInit.noInit)
            annotation (Placement(transformation(extent={{18,-104},{34,-120}})));
          Modelica.Fluid.Sources.Boundary_pT wAnodeShell_sink(
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            nPorts=1,
            p=1923000,
            T=605.838) annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={26,-78})));

          NHES.Electrolysis.ElectricHeaters.ToppingHeater_anodeGas_elecPort toppingHeater_anodeGas(
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            isCircular=true,
            initType=Modelica.Blocks.Types.Init.InitialOutput,
            TA_set=1123.15)
            annotation (Placement(transformation(extent={{52,-104},{68,-120}})));
          NHES.Electrolysis.Sensors.TempSensorWithThermowell TAtopping_out(
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=850 + 273.15,
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
            tau=13) annotation (Placement(transformation(extent={{70,-120},{90,-140}})));
          Modelica.Blocks.Continuous.FirstOrder actuator_wAnode_in(
            k=1,
            y_start=controlledSOEC.FBctrl_TC_out.y_start,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            T=8)  annotation (Placement(transformation(
                extent={{8,-8},{-8,8}},
                rotation=0,
                origin={-40,-194})));
          Modelica.Blocks.Continuous.FirstOrder actuator_wCathode_in(
            k=1,
            y_start=controlledSOEC.FBctrl_SUfactor.y_start,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            T=36)                                              annotation (
              Placement(transformation(
                extent={{8,-8},{-8,8}},
                rotation=0,
                origin={-40,76})));
          Modelica.Fluid.Valves.ValveLinear TCV_cathodeGas(
            allowFlowReversal=false,
            m_flow_small=0.001,
            show_T=true,
            redeclare package Medium = Medium,
            m_flow_start=6.47972,
            m_flow_nominal=6.47972,
            dp_start=(58 - 44.0804)*1e5,
            m_flow(start=6.47972, fixed=true),
            dp_nominal=actuator_TNOut_cathodeGas.y_start*((58 - 44.0804)*1e5))
                         annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-90,30})));
          Modelica.Fluid.Valves.ValveLinear TCV_anodeGas(
            allowFlowReversal=false,
            m_flow_small=0.001,
            m_flow_nominal=2.61448,
            show_T=true,
            m_flow_start=2.61448,
            redeclare package Medium = Medium,
            dp_start=(58 - 43.5)*1e5,
            dp_nominal=0.5*((58 - 43.5)*1e5),
            m_flow(start=2.61448, fixed=true))
                                  annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-90,-140})));
          Modelica.Fluid.Fittings.TeeJunctionIdeal flowSplit(
                               redeclare package Medium = Medium, port_2(p(start=5800000,
                  fixed=true)))                            annotation (Placement(
                transformation(
                extent={{10,-10},{-10,10}},
                rotation=0,
                origin={-126,-50})));
          Modelica.Fluid.Fittings.TeeJunctionIdeal flowJoin(redeclare package Medium =
                Medium)                             annotation (Placement(
                transformation(
                extent={{10,10},{-10,-10}},
                rotation=0,
                origin={-74,-78})));

          NHES.Electrolysis.Sensors.PowerSensorScalable W_HTSE(capacityScaler=
                capacityScaler) annotation (Placement(transformation(
                extent={{8,-8},{-8,8}},
                rotation=90,
                origin={146,0})));
          Modelica.Blocks.Sources.RealExpression mH2(y=capacityScaler*mH2_sec)
            annotation (Placement(transformation(extent={{-130,78},{-150,98}})));
          Modelica.Blocks.Sources.RealExpression mO2(y=capacityScaler*mO2_sec)
            annotation (Placement(transformation(extent={{-130,64},{-150,84}})));
          Modelica.Fluid.Sensors.Pressure pH2O_in(redeclare package Medium =
                Modelica.Media.Water.StandardWater)
            annotation (Placement(transformation(extent={{-132,48},{-148,64}})));
          Modelica.Fluid.Sensors.Temperature TH2O_in(redeclare package Medium =
                Modelica.Media.Water.StandardWater)
            annotation (Placement(transformation(extent={{-142,30},{-158,46}})));
          Modelica.Fluid.Sensors.MassFlowRate mH2O_in(redeclare package Medium =
                Modelica.Media.Water.StandardWater) annotation (Placement(
                transformation(
                extent={{8,-8},{-8,8}},
                rotation=90,
                origin={-140,0})));
          Modelica.Fluid.Sensors.MassFlowRate mH2O_out(redeclare package Medium =
                Modelica.Media.Water.StandardWater) annotation (Placement(
                transformation(
                extent={{8,-8},{-8,8}},
                rotation=90,
                origin={-138,-120})));
          Modelica.Fluid.Sensors.Temperature TH2O_out(redeclare package Medium =
                Modelica.Media.Water.StandardWater)
            annotation (Placement(transformation(extent={{-144,-104},{-160,-88}})));
          Modelica.Fluid.Sensors.Pressure pH2O_out(redeclare package Medium =
                Modelica.Media.Water.StandardWater)
            annotation (Placement(transformation(extent={{-136,-74},{-152,-58}})));
          Modelica.Fluid.Sources.Boundary_pT H2_sink(
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            nPorts=1,
            p=1960350,
            T=618.331) annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-40,-46})));
          NHES.Electrolysis.Fittings.IdealRecycle_H2 idealRecycle_H2(redeclare
              package
              Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas)
            annotation (Placement(transformation(extent={{-22,-52},{2,-28}})));
          NHES.Electrolysis.Separator.Temp_flashDrum flashDrum(redeclare
              package                                                            Medium =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas) annotation (Placement(
                transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={26,-40})));
          Modelica.Fluid.Sources.Boundary_pT H2O_sink(
            nPorts=1,
            redeclare package Medium =
                NHES.Electrolysis.Media.Electrolysis.CathodeGas,
            p=1960350,
            T=618.331) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={60,-40})));
          NHES.Electrolysis.Electrical.SwitchYard switchYard(powerConsumption_SOEC(
                fixed=true))
            annotation (Placement(transformation(extent={{50,-88},{70,-68}})));
          NHES.Electrolysis.Sensors.PowerSensorScalable W_SOEC(capacityScaler=
                capacityScaler) annotation (Placement(transformation(
                extent={{-8,-8},{8,8}},
                rotation=90,
                origin={86,-76})));
          Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_anodeGas(
            k=1,
            T=4,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=0.5)
                 annotation (Placement(transformation(
                extent={{8,-8},{-8,8}},
                rotation=0,
                origin={-68,-160})));
          NHES.Electrolysis.HTSE.Intermediate_HTSE.IdealPump returnPump(
            redeclare package Medium = Medium,
            PR0=60.9167/43.1691*0 + 59.02/43.1793,
            pstart_out=5902000,
            Tstart=488.787)
            annotation (Placement(transformation(extent={{-92,-86},{-108,-70}})));
          NHES.Electrical.Sources.PowerSource W_IP(use_W_in=true, W=51145400)
            annotation (Placement(transformation(
                extent={{-6,6},{6,-6}},
                rotation=270,
                origin={146,26})));
         Journal_IES_Simulations.Components.HTSE.LoadModified load_IP(Wn=0, fn=60) annotation (Placement(
                transformation(
                extent={{-13,-13},{13,13}},
                rotation=180,
                origin={141,-41})));
          NHES.Fluid.Pipes.parallelFlow nFlow_in(redeclare package Medium = Medium,
              nParallel=capacityScaler_steamFlow) annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={-140,-22})));
          NHES.Fluid.Pipes.parallelFlow nFlow_out(redeclare package Medium = Medium,
              nParallel=capacityScaler_steamFlow) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={-128,-78})));
          Modelica.Blocks.Math.Gain scaler_IP(k=capacityScaler) annotation (Placement(
                transformation(
                extent={{4,-4},{-4,4}},
                rotation=0,
                origin={152,-40})));
        equation
          mH2_sec = hEX_cathodeGasRecup_ROM.wShell_out*hEX_cathodeGasRecup_ROM.XShell_out[1] - cascadeCtrl_yH2.mixtureGas_port_1.m_flow;
          mH2_yr =  mH2_sec*60*60*24*365;
          mO2_sec = controlledSOEC.SOECstack.deltaM_O2*controlledSOEC.numVessels;
          mO2_yr = mO2_sec*60*60*24*365;

          Q_nuclearHeatCathodeRecup = hEX_nuclearHeatCathodeGasRecup_ROM.QTube_gained;
          Q_nuclearHeatAnodeRecup = hEX_nuclearHeatAnodeGasRecup_ROM.QTube_gained;
          Q_nuclearHeatRecup = Q_nuclearHeatCathodeRecup + Q_nuclearHeatAnodeRecup;
          Wq_nuclearHeatRecup = Q_nuclearHeatRecup*eta_powerCycle;

          W_total =switchYard.totalElec_sink.W + Wq_nuclearHeatRecup;

          We_HTSE_percent =(switchYard.totalElec_sink.W/W_total)*100;
          Wq_HTSE_percent = (Wq_nuclearHeatRecup/W_total)*100;

          connect(toppingHeater_cathodeGas.port_a,hEX_cathodeGasRecup_ROM. tube_out)
            annotation (Line(points={{52,-12},{52,-12},{34,-12}},
                                                               color={0,127,255}));
          connect(controlledSOEC.ctrlCathodeOut,hEX_cathodeGasRecup_ROM. shell_in)
            annotation (Line(points={{127.58,-50.5},{134,-50.5},{134,30},{26,30},{26,-4}},
                        color={0,127,255}));
          connect(toppingHeater_cathodeGas.s_TC_in,TCtopping_out. y) annotation (Line(
                points={{60,-3.2},{60,20},{80,20},{80,15}}, color={0,0,127}));
          connect(cascadeCtrl_yH2.mixtureGas_port_3,hEX_cathodeGasRecup_ROM. tube_in)
            annotation (Line(points={{-0.4,-12},{8,-12},{18,-12}},
                                                          color={0,127,255}));
          connect(hEX_nuclearHeatCathodeGasRecup_ROM.tube_out,cascadeCtrl_yH2. steam_port_2)
            annotation (Line(points={{-52,-6},{-52,-6},{-19.6,-6}},
                                                           color={0,127,255}));
          connect(TNOut_cathodeGasSensor.port,cascadeCtrl_yH2. steam_port_2)
            annotation (Line(points={{-40,8},{-40,-6},{-19.6,-6}},  color={0,0,127}));
          connect(feedCathodeGas.ports[1],hEX_nuclearHeatCathodeGasRecup_ROM. tube_in)
            annotation (Line(points={{-86,-6},{-86,-6},{-68,-6}},
                                                         color={0,127,255}));
          connect(feedAnodeGas.ports[1],hEX_nuclearHeatAnodeGasRecup_ROM. tube_in)
            annotation (Line(points={{-86,-112},{-86,-112},{-68,-112}},
                                                               color={0,127,255}));
          connect(hEX_nuclearHeatAnodeGasRecup_ROM.tube_out,hEX_anodeGasRecup_ROM.
                                  tube_in) annotation (Line(points={{-52,-112},{-52,
                  -112},{18,-112}},
                                  color={0,127,255}));
          connect(hEX_anodeGasRecup_ROM.tube_out,toppingHeater_anodeGas. port_a)
            annotation (Line(points={{34,-112},{34,-112},{52,-112}},
                                                                  color={0,127,255}));
          connect(TAtopping_out.y,toppingHeater_anodeGas. s_TA_in) annotation (Line(
                points={{80,-139},{80,-144},{60,-144},{60,-120.8}},
                                                                color={0,0,127}));
          connect(wAnodeShell_sink.ports[1], hEX_anodeGasRecup_ROM.shell_out)
            annotation (Line(points={{26,-88},{26,-104}},color={0,127,255}));
          connect(TNOut_anodeGasSensor.port,hEX_anodeGasRecup_ROM. tube_in) annotation (
             Line(points={{-40,-124},{-40,-112},{18,-112}},
                                                         color={0,0,127}));
          connect(controlledSOEC.ctrlAnodeOut,hEX_anodeGasRecup_ROM. shell_in)
            annotation (Line(points={{127.58,-64.78},{134,-64.78},{134,-150},{26,-150},
                  {26,-120}},color={0,127,255}));
          connect(controlledSOEC.c_wAnodeIn,actuator_wAnode_in. u) annotation (
              Line(points={{113.64,-71.58},{113.64,-194},{-30.4,-194}},color={0,0,
                  127}));
          connect(actuator_wAnode_in.y,feedAnodeGas. m_flow_in) annotation (Line(
                points={{-48.8,-194},{-116,-194},{-116,-104},{-106,-104}},
                                                                        color={0,
                  0,127}));
          connect(controlledSOEC.c_wCathode,actuator_wCathode_in. u) annotation (
              Line(points={{115,-48.8},{115,76},{-30.4,76}}, color={0,0,127}));
          connect(actuator_wCathode_in.y,feedCathodeGas. m_flow_in) annotation (
              Line(points={{-48.8,76},{-116,76},{-116,2},{-106,2}},   color={0,0,
                  127}));
          connect(TCV_cathodeGas.port_b, hEX_nuclearHeatCathodeGasRecup_ROM.shell_in)
            annotation (Line(points={{-80,30},{-60,30},{-60,2}},  color={0,127,255}));
          connect(hEX_nuclearHeatAnodeGasRecup_ROM.shell_in, TCV_anodeGas.port_b)
            annotation (Line(points={{-60,-120},{-60,-140},{-80,-140}},
                                                                     color={0,127,
                  255}));
          connect(flowSplit.port_3, TCV_cathodeGas.port_a) annotation (Line(points={{-126,
                  -40},{-126,30},{-100,30}},       color={0,127,255}));
          connect(actuator_TNOut_cathodeGas.y, TCV_cathodeGas.opening) annotation (
              Line(points={{-76.8,48},{-90,48},{-90,38}},     color={0,0,127}));
          connect(flowSplit.port_1, TCV_anodeGas.port_a) annotation (Line(points={{-116,
                  -50},{-112,-50},{-112,-140},{-100,-140}},  color={0,127,255}));
          connect(TCtopping_out.port, toppingHeater_cathodeGas.port_b)
            annotation (Line(points={{80,-4},{80,-12},{68,-12}},
                                                               color={0,0,127}));
          connect(TAtopping_out.port, toppingHeater_anodeGas.port_b) annotation (
              Line(points={{80,-120},{80,-112},{68,-112}},
                                                        color={0,0,127}));
          connect(controlledSOEC.ctrlAnodeIn, toppingHeater_anodeGas.port_b)
            annotation (Line(points={{102.42,-68.18},{96,-68.18},{96,-112},{68,-112}},
                color={0,127,255}));
          connect(controlledSOEC.ctrlCathodeIn, toppingHeater_cathodeGas.port_b)
            annotation (Line(points={{102.42,-53.9},{96,-53.9},{96,-12},{68,-12}},
                                                                             color=
                  {0,127,255}));
          connect(mH2O_in.port_a, port_a) annotation (Line(points={{-140,8},{-140,20},{
                  -200,20}},      color={0,127,255}));
          connect(mH2O_in.port_a, TH2O_in.port) annotation (Line(points={{-140,8},{-140,
                  26},{-150,26},{-150,30}},       color={0,0,127}));
          connect(pH2O_in.port, TH2O_in.port) annotation (Line(points={{-140,48},{-140,
                  26},{-150,26},{-150,30}},      color={0,0,127}));
          connect(hEX_nuclearHeatCathodeGasRecup_ROM.shell_out, flowJoin.port_1)
            annotation (Line(points={{-60,-14},{-60,-78},{-64,-78}},color={0,127,
                  255}));
          connect(flowJoin.port_3, hEX_nuclearHeatAnodeGasRecup_ROM.shell_out)
            annotation (Line(points={{-74,-88},{-74,-94},{-60,-94},{-60,-104}},
                color={0,127,255}));
          connect(hEX_cathodeGasRecup_ROM.shell_out, flashDrum.feedInlet)
            annotation (Line(points={{26,-20},{26,-26},{26,-32}},
                                                               color={0,127,255}));
          connect(H2O_sink.ports[1], flashDrum.liquidOutlet)
            annotation (Line(points={{50,-40},{35,-40}},       color={0,127,255}));
          connect(flashDrum.vaporOutlet, idealRecycle_H2.H2_feed) annotation (Line(
                points={{17,-40},{-0.4,-40}},         color={0,127,255}));
          connect(cascadeCtrl_yH2.c_yH2, idealRecycle_H2.c_yH2) annotation (Line(
                points={{-5.2,-15.36},{-5.2,-26},{-5.2,-37.36}},        color={0,0,
                  127}));
          connect(H2_sink.ports[1], idealRecycle_H2.H2_prod) annotation (Line(
                points={{-30,-46},{-19.6,-46}},          color={0,127,255}));
          connect(idealRecycle_H2.H2_recycle, cascadeCtrl_yH2.mixtureGas_port_1)
            annotation (Line(points={{-19.6,-34},{-26,-34},{-26,-18},{-19.6,-18}},
                color={0,127,255}));
          connect(toppingHeater_cathodeGas.loadElecHeater, switchYard.load_catElecHeater)
            annotation (Line(points={{60,-20},{60,-26},{74,-26},{74,-60},{52,-60},{52,
                  -70}},
                color={255,0,0},thickness=0.5));
          connect(toppingHeater_anodeGas.loadElecHeater, switchYard.load_anElecHeater)
            annotation (Line(points={{60,-104},{60,-94},{52,-94},{52,-86}},color={255,0,
                  0},thickness=0.5));
          connect(W_HTSE.port_b, switchYard.totalElecPower) annotation (Line(
              points={{146.16,-8},{146,-8},{146,-26},{80,-26},{80,-70},{68,-70}},
              color={255,0,0},
              thickness=0.5));
          connect(W_SOEC.port_b, controlledSOEC.ctrlElectricalLoad) annotation (Line(
              points={{86.16,-68},{86,-68},{86,-60.7},{102.08,-60.7}},
              color={255,0,0},
              thickness=0.5));
          connect(switchYard.load_SOEC, W_SOEC.port_a) annotation (Line(
              points={{68,-86},{86,-86},{86,-84}},
              color={255,0,0},
              thickness=0.5));
          connect(actuator_TNOut_anodeGas.y, TCV_anodeGas.opening) annotation (Line(
                points={{-76.8,-160},{-90,-160},{-90,-148}},color={0,0,127}));
          connect(returnPump.inlet, flowJoin.port_2) annotation (Line(points={{-92,-78},
                  {-88,-78},{-84,-78}}, color={0,127,255}));
          connect(sensorBus.T_out, TH2O_out.T) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,-96},{-157.6,-96}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));

          connect(sensorBus.m_flow_out, mH2O_out.m_flow) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,-120},{-146.8,-120}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));

          connect(sensorBus.p_out, pH2O_out.p) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,-66},{-152.8,-66}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.m_flow_in, mH2O_in.m_flow) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,0},{-148.8,0}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.T_in, TH2O_in.T) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,38},{-155.6,38}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.p_in, pH2O_in.p) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,56},{-148.8,56}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));

          connect(sensorBus.m_flow_O2_prod, mO2.y) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,74},{-151,74}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.m_flow_H2_prod, mH2.y) annotation (Line(
              points={{-29.9,100.1},{-29.9,100.1},{-160,100.1},{-160,88},{-151,88}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.W_SOEC, W_SOEC.W) annotation (Line(
              points={{-29.9,100.1},{66,100.1},{160,100.1},{160,-76},{93.52,-76}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.W_HTSE, W_HTSE.W) annotation (Line(
              points={{-29.9,100.1},{160,100.1},{160,0},{153.52,0}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.TNOut_anodeGas, TNOut_anodeGasSensor.y)
            annotation (Line(
              points={{-29.9,100.1},{64,100.1},{160,100.1},{160,-156},{-40,-156},{-40,
                  -143}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));

          connect(sensorBus.TNOut_cathodeGas, TNOut_cathodeGasSensor.y)
            annotation (Line(
              points={{-29.9,100.1},{0,100.1},{0,40},{-40,40},{-40,27}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(actuatorBus.subBus_IP.HTSE.TNOut_cathodeGas, actuator_TNOut_cathodeGas.u)
            annotation (Line(
              points={{30,100},{30,100},{30,92},{30,48},{-58.4,48}},
              color={111,216,99},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(actuatorBus.subBus_IP.HTSE.TNOut_anodeGas, actuator_TNOut_anodeGas.u)
            annotation (Line(
              points={{30,100},{30,100},{30,100},{30,104},{164,104},{164,-160},{-58.4,-160}},
              color={111,216,99},
              pattern=LinePattern.Dash,
              thickness=0.5));

          connect(W_IP.portElec_a, W_HTSE.port_a) annotation (Line(
              points={{146,20},{146,20},{146,8}},
              color={255,0,0},
              thickness=0.5));
          connect(actuatorBus.subBus_IP.HTSE.W_IP, W_IP.W_in) annotation (Line(
              points={{30,100},{30,100},{30,100},{30,104},{164,104},{164,40},{146,40},{146,
                  33.2}},
              color={111,216,99},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(nFlow_out.port_b, returnPump.outlet)
            annotation (Line(points={{-118,-78},{-108,-78}}, color={0,127,255}));
          connect(nFlow_out.port_a, mH2O_out.port_a) annotation (Line(points={{-138,-78},
                  {-138,-78},{-138,-112}},color={0,127,255}));
          connect(mH2O_in.port_b, nFlow_in.port_a)
            annotation (Line(points={{-140,-8},{-140,-12}},color={0,127,255}));
          connect(nFlow_in.port_b, flowSplit.port_2) annotation (Line(points={{-140,-32},
                  {-140,-50},{-136,-50}},
                                        color={0,127,255}));
          connect(load_IP.powerConsumption, scaler_IP.y)
            annotation (Line(points={{145.29,-41},{146,-41},{146,-40},{147.6,-40}},
                                                              color={0,0,127}));
          connect(actuatorBus.subBus_IP.HTSE.W_IP, scaler_IP.u) annotation (Line(
              points={{30,100},{30,100},{30,100},{30,104},{164,104},{164,-40},{156.8,-40}},
              color={111,216,99},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(port_b, mH2O_out.port_b) annotation (Line(points={{-200,-140},{-138,
                  -140},{-138,-128}},
                                color={0,127,255}));
          connect(TH2O_out.port, nFlow_out.port_b) annotation (Line(points={{-152,-104},
                  {-144,-104},{-144,-78},{-118,-78}}, color={0,127,255}));
          connect(nFlow_out.port_a, pH2O_out.port) annotation (Line(points={{-138,-78},
                  {-144,-78},{-144,-74}}, color={0,0,127}));
          connect(load_IP.portElec_a, portElec_a) annotation (Line(points={{141,-51.4},
                  {141,-60},{200,-60}}, color={255,0,0}));
          annotation (defaultComponentName="IP",
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-220},{200,
                    140}})),            Icon(coordinateSystem(preserveAspectRatio=false,
                           extent={{-100,-100},{100,100}}), graphics={Bitmap(extent={{
                      -72,-56},{74,26}},
                  imageSource=
                      "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"
                       +
                      "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"
                       +
                      "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"
                       +
                      "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",
                  fileName=
                      "modelica://NHES/../Resources/Images/Systems/IP/Electrolysis/HTSE.png"),
                          Text(
                  extent={{-94,76},{94,68}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,237},
                  fillPattern=FillPattern.Solid,
                  textString="High-Temperature
Steam Electrolysis")}));
        end HTSESteamFlowCtrl_GenericModular;

        model CS_TightlyCoupled_SteamFlowCtrl_original
          extends
            NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_ControlSystem;

          parameter Real delayStart=5000 "Time to start tracking power profiles";
          parameter Real capacityScaler = 1 "Scaler that sizes the capacity of the overall system";
          parameter Modelica.Units.SI.Power W_IP_nom(displayUnit="MW")=51.1454e6
            "Nominal electrical power consumption in the IP";
          final parameter Modelica.Units.SI.Power W_IP_max(displayUnit="MW")=
            W_IP_nom*1.05 "Maximum electrical power consumption in the IP";
          parameter Modelica.Units.SI.Power W_IP_min(displayUnit="MW")=20.9561e6
            "Minimum electrical power consumption in the IP";

          input Modelica.Units.SI.Power W_totalSetpoint "Total setpoint power"
            annotation (Dialog(group="Inputs"));

          Modelica.Blocks.Sources.Ramp TNOut_anodeGas_set(
            offset=259 + 273.15,
            height=0,
            duration=0,
            y(displayUnit="degC", unit="K"),
            startTime=0)  annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-50,70})));
          Modelica.Blocks.Continuous.LimPID FBctrl_TNOut_anodeGas(
            controllerType=Modelica.Blocks.Types.SimpleController.PI,
            yMax=1,
            yMin=0.05,
            xi_start=0.5/FBctrl_TNOut_anodeGas.k,
            y_start=0.5,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            k=(1/223.36)*5,
            Ti=47.1571789477849,
            y(start=FBctrl_TNOut_anodeGas.y_start),
            gainPID(y(start=FBctrl_TNOut_anodeGas.y_start))) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={-10,70})));
          Modelica.Blocks.Sources.Ramp TNOut_cathodeGas_set(
            duration=0,
            height=0,
            startTime=0,
            offset=283.4 + 273.15,
            y(displayUnit="degC", unit="K"))
                          annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-50,20})));
          Modelica.Blocks.Continuous.LimPID FBctrl_TNOut_cathodeGas(
            controllerType=Modelica.Blocks.Types.SimpleController.PI,
            yMax=1,
            initType=Modelica.Blocks.Types.Init.InitialState,
            k=1/252.35*1.5,
            xi_start=FBctrl_TNOut_cathodeGas.y_start/FBctrl_TNOut_cathodeGas.k,
            gainPID(y(start=FBctrl_TNOut_cathodeGas.y_start)),
            y_start=0.85,
            y(start=FBctrl_TNOut_cathodeGas.y_start),
            Ti=159.9663300632,
            yMin=0.75) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={-10,20})));
          Modelica.Blocks.Nonlinear.Limiter limiter_W_IP(uMax=W_IP_max, uMin=W_IP_min)
                           annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={70,-40})));
          Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=delayStart)
            annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
          Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
            annotation (Placement(transformation(extent={{-90,-50},{-70,-30}})));
          Modelica.Blocks.Logical.Switch switch
            annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
          Modelica.Blocks.Sources.Constant W_IP_nominal(k=W_IP_nom)
            annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
          Modelica.Blocks.Math.Gain scaler(k=1/capacityScaler)
            annotation (Placement(transformation(extent={{-14,-66},{-2,-54}})));
          Modelica.Blocks.Sources.RealExpression W_totalSetpoint_IP(y=W_totalSetpoint)
            annotation (Placement(transformation(extent={{-60,-82},{-40,-62}})));
        equation

          connect(FBctrl_TNOut_anodeGas.u_s,TNOut_anodeGas_set. y)
            annotation (Line(points={{-22,70},{-22,70},{-39,70}},color={0,0,127}));
          connect(TNOut_cathodeGas_set.y, FBctrl_TNOut_cathodeGas.u_s)
            annotation (Line(points={{-39,20},{-39,20},{-22,20}},color={0,0,127}));
          connect(sensorBus.TNOut_anodeGas, FBctrl_TNOut_anodeGas.u_m)
            annotation (Line(
              points={{-29.9,-99.9},{-100,-99.9},{-100,50},{-10,50},{-10,58}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.TNOut_cathodeGas, FBctrl_TNOut_cathodeGas.u_m)
            annotation (Line(
              points={{-29.9,-99.9},{-30,-99.9},{-30,-100},{-100,-100},{-100,0},{
                  -10,0},{-10,8}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(actuatorBus.subBus_IP.HTSE.TNOut_anodeGas, FBctrl_TNOut_anodeGas.y)
            annotation (Line(
              points={{30,-100},{100,-100},{100,70},{1,70}},
              color={111,216,99},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(actuatorBus.subBus_IP.HTSE.TNOut_cathodeGas, FBctrl_TNOut_cathodeGas.y)
            annotation (Line(
              points={{30,-100},{30,-100},{100,-100},{100,20},{1,20}},
              color={111,216,99},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(actuatorBus.subBus_IP.HTSE.W_IP, limiter_W_IP.y) annotation (Line(
              points={{30,-100},{64,-100},{100,-100},{100,-40},{81,-40}},
              color={111,216,99},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(limiter_W_IP.u, switch.y)
            annotation (Line(points={{58,-40},{58,-40},{41,-40}}, color={0,0,127}));
          connect(lessThreshold.y, switch.u2)
            annotation (Line(points={{-29,-40},{18,-40}}, color={255,0,255}));
          connect(clock.y, lessThreshold.u)
            annotation (Line(points={{-69,-40},{-58,-40},{-52,-40}}, color={0,0,127}));
          connect(W_IP_nominal.y, switch.u1) annotation (Line(points={{1,-20},{10,-20},{
                  10,-32},{18,-32}}, color={0,0,127}));
          connect(scaler.y, switch.u3) annotation (Line(points={{-1.4,-60},{10,-60},{10,
                  -48},{18,-48}}, color={0,0,127}));
          connect(W_totalSetpoint_IP.y, scaler.u) annotation (Line(points={{-39,-72},{-26,
                  -72},{-26,-60},{-15.2,-60}}, color={0,0,127}));
        annotation(defaultComponentName="CS");
        end CS_TightlyCoupled_SteamFlowCtrl_original;

        model CS_TightlyCoupled_SteamFlowCtrl_modified
          extends
            NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_ControlSystem;

          parameter Real delayStart=5000 "Time to start tracking power profiles";
          parameter Real capacityScaler = 1 "Scaler that sizes the capacity of the overall system";
          parameter Modelica.Units.SI.Power W_IP_nom(displayUnit="MW")=51.1454e6
            "Nominal electrical power consumption in the IP";
          final parameter Modelica.Units.SI.Power W_IP_max(displayUnit="MW")=W_IP_nom*1.05
            "Maximum electrical power consumption in the IP";
          parameter Modelica.Units.SI.Power W_IP_min(displayUnit="MW")=20.9561e6
            "Minimum electrical power consumption in the IP";

          input Modelica.Units.SI.Power W_totalSetpoint "Total setpoint power"
            annotation (Dialog(group="Inputs"));

          Modelica.Blocks.Sources.Ramp TNOut_anodeGas_set(
            offset=259 + 273.15,
            height=0,
            duration=0,
            y(displayUnit="degC", unit="K"),
            startTime=0)  annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-50,70})));
          Modelica.Blocks.Continuous.LimPID FBctrl_TNOut_anodeGas(
            controllerType=Modelica.Blocks.Types.SimpleController.PI,
            yMax=1,
            yMin=0.05,
            xi_start=0.5/FBctrl_TNOut_anodeGas.k,
            y_start=0.5,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            k=(1/223.36)*5,
            Ti=47.1571789477849,
            y(start=FBctrl_TNOut_anodeGas.y_start),
            gainPID(y(start=FBctrl_TNOut_anodeGas.y_start))) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={-10,70})));
          Modelica.Blocks.Sources.Ramp TNOut_cathodeGas_set(
            duration=0,
            height=0,
            startTime=0,
            offset=283.4 + 273.15,
            y(displayUnit="degC", unit="K"))
                          annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-50,20})));
          Modelica.Blocks.Continuous.LimPID FBctrl_TNOut_cathodeGas(
            controllerType=Modelica.Blocks.Types.SimpleController.PI,
            yMax=1,
            initType=Modelica.Blocks.Types.Init.InitialState,
            k=1/252.35*1.5,
            xi_start=FBctrl_TNOut_cathodeGas.y_start/FBctrl_TNOut_cathodeGas.k,
            gainPID(y(start=FBctrl_TNOut_cathodeGas.y_start)),
            y_start=0.85,
            y(start=FBctrl_TNOut_cathodeGas.y_start),
            Ti=159.9663300632,
            yMin=0.75) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={-10,20})));
          Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=delayStart)
            annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
          Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
            annotation (Placement(transformation(extent={{-90,-50},{-70,-30}})));
          Modelica.Blocks.Logical.Switch switch
            annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
          Modelica.Blocks.Sources.Constant W_IP_nominal(k=W_IP_nom)
            annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
          Modelica.Blocks.Sources.RealExpression W_totalSetpoint_IP(y=W_totalSetpoint)
            annotation (Placement(transformation(extent={{-60,-82},{-40,-62}})));
        equation

          connect(FBctrl_TNOut_anodeGas.u_s,TNOut_anodeGas_set. y)
            annotation (Line(points={{-22,70},{-22,70},{-39,70}},color={0,0,127}));
          connect(TNOut_cathodeGas_set.y, FBctrl_TNOut_cathodeGas.u_s)
            annotation (Line(points={{-39,20},{-39,20},{-22,20}},color={0,0,127}));
          connect(sensorBus.TNOut_anodeGas, FBctrl_TNOut_anodeGas.u_m)
            annotation (Line(
              points={{-29.9,-99.9},{-100,-99.9},{-100,50},{-10,50},{-10,58}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(sensorBus.TNOut_cathodeGas, FBctrl_TNOut_cathodeGas.u_m)
            annotation (Line(
              points={{-29.9,-99.9},{-30,-99.9},{-30,-100},{-100,-100},{-100,0},{-10,0},
                  {-10,8}},
              color={239,82,82},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(actuatorBus.subBus_IP.HTSE.TNOut_anodeGas, FBctrl_TNOut_anodeGas.y)
            annotation (Line(
              points={{30,-100},{100,-100},{100,70},{1,70}},
              color={111,216,99},
              pattern=LinePattern.Dash,
              thickness=0.5));
          connect(actuatorBus.subBus_IP.HTSE.TNOut_cathodeGas, FBctrl_TNOut_cathodeGas.y)
            annotation (Line(
              points={{30,-100},{30,-100},{100,-100},{100,20},{1,20}},
              color={111,216,99},
              pattern=LinePattern.Dash,
              thickness=0.5));

          connect(lessThreshold.y, switch.u2)
            annotation (Line(points={{-29,-40},{18,-40}}, color={255,0,255}));
          connect(clock.y, lessThreshold.u)
            annotation (Line(points={{-69,-40},{-58,-40},{-52,-40}}, color={0,0,127}));
          connect(switch.y,actuatorBus.subBus_IP.HTSE.W_IP);
          connect(W_IP_nominal.y, switch.u1) annotation (Line(points={{1,-20},{10,-20},{
                  10,-32},{18,-32}}, color={0,0,127}));
          connect(W_totalSetpoint_IP.y, switch.u3) annotation (Line(points={{-39,
                  -72},{-10,-72},{-10,-48},{18,-48}}, color={0,0,127}));
                  annotation(defaultComponentName="CS");
        end CS_TightlyCoupled_SteamFlowCtrl_modified;
      end SteamControl;

      model LoadModified "Electrical load"
        parameter Modelica.Units.SI.Power Wn "Nominal active power consumption";
        parameter Modelica.Units.SI.Frequency fn=60 "Nominal frequency";

        Modelica.Units.SI.Power W "Actual power consumption";
        Modelica.Units.SI.Frequency f "Frequency";
        Modelica.Blocks.Interfaces.RealInput powerConsumption annotation (Placement(
              transformation(
              origin={-33,0},
              extent={{13,12},{-13,-12}},
              rotation=180)));
        NHES.Electrical.Interfaces.ElectricalPowerPort_a portElec_a annotation (
            Placement(transformation(extent={{-10,70},{10,90}}), iconTransformation(
                extent={{-10,70},{10,90}})));
      equation
        if cardinality(powerConsumption) == 1 then
          W = powerConsumption
            "Power consumption determined by connector";
        else
          powerConsumption = Wn "Set the connector value (not used)";
          W = Wn
            "Power consumption determined by parameter";
        end if;
        portElec_a.f = f;
        portElec_a.W = W;
        annotation (
          extent=[-20, 80; 0, 100],
          rotation=-90,
          Icon(graphics={Line(points={{0,40},{0,74}}, color={0,0,0}),Rectangle(
                    extent={{-20,40},{20,-40}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={255,255,255},
                    fillPattern=FillPattern.Solid),Line(points={{0,-40},{0,-68}},
                color={0,0,0}),Line(points={{16,-68},{-16,-68}}, color={0,0,0}),
                Line(points={{8,-76},{-8,-76}}, color={0,0,0}),Line(points={{-2,-84},
                {4,-84}}, color={0,0,0})}),
          Placement(transformation(
              origin={-10,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
      end LoadModified;
    end HTSE;

    package EM
      model SteamManifold_L1_valves_manual
        import NHES;
        extends
          NHES.Systems.EnergyManifold.SteamManifold.BaseClasses.Partial_SubSystem_C(
          redeclare replaceable
            NHES.Systems.EnergyManifold.SteamManifold.CS_Dummy CS(nPorts_b3=
                nPorts_b3),
          redeclare replaceable
            NHES.Systems.EnergyManifold.SteamManifold.ED_Dummy ED,
          redeclare
            NHES.Systems.EnergyManifold.SteamManifold.Data.SteamManifold data,
          redeclare final package Medium_1 = Medium,
          redeclare final package Medium_2 = Medium,
          redeclare final package Medium_3 = Medium,
          port_b2_nominal(p=port_a1_nominal.p - dp_nominal_valve_b2),
          port_b3_nominal_p={port_a1_nominal.p - dp_nominal_valve_b3[i] for i in
                  1:nPorts_b3});

        replaceable package Medium = Modelica.Media.Water.StandardWater
          constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium annotation (
            choicesAllMatching=true);

        parameter Modelica.Units.SI.PressureDifference dp_nominal_valve_b2=1e4
          "Nominal pressure drop at full opening"
          annotation (Dialog(tab="Nominal Conditions"));
        parameter Modelica.Units.SI.PressureDifference dp_nominal_valve_b3[nPorts_b3]=
           fill(1e4, nPorts_b3) "Nominal pressure drop at full opening"
          annotation (Dialog(tab="Nominal Conditions"));

        parameter Boolean use_pipeDelay_b2=false
          "=true to use include pipe effects due to distance"
          annotation (Dialog(group="port_b2 (e.g., Balance of Plant)"));
        parameter Modelica.Units.SI.Length length_b2=10
          "Length of pipe to port_b2" annotation (Dialog(group=
                "port_b2 (e.g., Balance of Plant)", enable=use_pipeDelay_b2));
        parameter Modelica.Units.SI.Diameter diameter_b2=2.5
          "Diameter of pipe to port_b2" annotation (Dialog(group=
                "port_b2 (e.g., Balance of Plant)", enable=use_pipeDelay_b2));

        parameter Boolean use_pipeDelay_a2=use_pipeDelay_b2
          "=true to use include pipe effects due to distance"
          annotation (Dialog(group="port_a2 (e.g., Balance of Plant)"));
        parameter Modelica.Units.SI.Length length_a2=length_b2
          "Length of pipe from port_a2" annotation (Dialog(group=
                "port_a2 (e.g., Balance of Plant)", enable=use_pipeDelay_b2));
        parameter Modelica.Units.SI.Diameter diameter_a2=diameter_b2
          "Diameter of pipe from port_a2" annotation (Dialog(group=
                "port_a2 (e.g., Balance of Plant)", enable=use_pipeDelay_b2));

        parameter Boolean use_pipeDelay_b3=false
          "=true to use include pipe effects due to distance"
          annotation (Dialog(group="port_b3 (e.g., Industrial Process)"));
        parameter Modelica.Units.SI.Length[nPorts_b3] length_b3=fill(10,
            nPorts_b3) "Lengtsh of pipe to port_b3" annotation (Dialog(group=
                "port_b3 (e.g., Industrial Process)", enable=use_pipeDelay_b3));
        parameter Modelica.Units.SI.Diameter[nPorts_b3] diameter_b3=fill(2.5,
            nPorts_b3) "Diameter of pipes to ports_b3" annotation (Dialog(group=
               "port_b3 (e.g., Industrial Process)", enable=use_pipeDelay_b3));

        TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(R=1,
            redeclare package Medium = Medium)
          annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
        TRANSFORM.Fluid.Volumes.MixingVolume steamHeader(
          use_T_start=false,
          nPorts_a=1,
          nPorts_b=1 + nPorts_b3,
          redeclare package Medium = Medium,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
              (V=20),
          p_start=port_a1_start.p,
          h_start=port_a1_start.h)
          annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
        TRANSFORM.Fluid.Valves.ValveIncompressible valve_b2(
          rho_nominal=Medium_1.density_ph(port_a1_nominal.p, port_a1_nominal.h),
          redeclare package Medium = Medium,
          m_flow_nominal=port_a1_nominal.m_flow,
          dp_nominal=dp_nominal_valve_b2)
          annotation (Placement(transformation(extent={{28,30},{48,50}})));
        TRANSFORM.Fluid.Valves.ValveIncompressible valve_b3[nPorts_b3](
          redeclare each package Medium = Medium,
          each rho_nominal=Medium_1.density_ph(port_a1_nominal.p, port_a1_nominal.h),
          m_flow_nominal=9,
          dp_nominal=dp_nominal_valve_b3) if
                                     nPorts_b3 > 0 annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={38,8})));

        TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_b2(
          redeclare package Medium = Medium,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
              (
              dimension=diameter_b2,
              length=length_b2,
              nV=2),
          exposeState_b=true,
          use_Ts_start=false,
          h_a_start=port_a1_start.h,
          h_b_start=port_a1_start.h,
          p_a_start=port_a1_start.p - valve_b2.dp_start,
          m_flow_a_start=-port_b2_start.m_flow)
          annotation (Placement(transformation(extent={{60,30},{80,50}})));
        TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_b3[nPorts_b3](
          redeclare package Medium = Medium,
          each exposeState_b=true,
          h_a_start=fill(port_a1_start.h, nPorts_b3),
          h_b_start=fill(port_a1_start.h, nPorts_b3),
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
              (
              each nV=2,
              dimension=diameter_b3,
              length=length_b3),
          m_flow_a_start=-port_b3_start_m_flow,
          p_a_start={port_a1_start.p - valve_b3[i].dp_start for i in 1:nPorts_b3},
          each use_Ts_start=false) if
                                     nPorts_b3 > 0 annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={40,-26})));
        TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_a2(
          redeclare package Medium = Medium,
          exposeState_b=true,
          use_Ts_start=false,
          p_a_start=port_a2_start.p,
          h_a_start=port_a2_start.h,
          h_b_start=port_a2_start.h,
          m_flow_a_start=port_a2_start.m_flow,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
              (
              nV=2,
              dimension=diameter_a2,
              length=length_a2))
          annotation (Placement(transformation(extent={{10,-50},{-10,-30}})));
        Modelica.Blocks.Sources.Constant const(k=0.1)
          annotation (Placement(transformation(extent={{10,56},{30,76}})));
        Modelica.Blocks.Sources.Constant const1(k=0.001) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={84,-10})));
      equation

        // Conditional Connections based on # of ports
        for i in 1:nPorts_b3 loop
          connect(valve_b3[i].port_a, steamHeader.port_b[i + 1]);
        end for;

        // Conditional pipe delay to port_b3
        if use_pipeDelay_b3 then
          for i in 1:nPorts_b3 loop
            connect(valve_b3[i].port_b, pipe_b3[i].port_a);
            connect(pipe_b3[i].port_b, port_b3[i]);
          end for;
        else
          for i in 1:nPorts_b3 loop
            connect(valve_b3[i].port_b, port_b3[i]);
          end for;
        end if;

        // Conditional pipe delay to port_b2
        if use_pipeDelay_b2 then
          connect(valve_b2.port_b, pipe_b2.port_a);
          connect(pipe_b2.port_b, port_b2);
        else
          connect(valve_b2.port_b, port_b2);
        end if;

        // Conditional pipe delay from port_a2
        if use_pipeDelay_a2 then
          connect(port_a2, pipe_a2.port_a);
          connect(pipe_a2.port_b, port_b1);
        else
          connect(port_a2, port_b1);
        end if;

        connect(port_a1, resistance.port_a)
          annotation (Line(points={{-100,40},{-77,40}}, color={0,127,255}));

        connect(resistance.port_b, steamHeader.port_a[1])
          annotation (Line(points={{-63,40},{-46,40}}, color={0,127,255}));
        connect(steamHeader.port_b[1], valve_b2.port_a)
          annotation (Line(points={{-34,40},{28,40}}, color={0,127,255}));

        connect(const.y, valve_b2.opening)
          annotation (Line(points={{31,66},{38,66},{38,48}}, color={0,0,127}));
        connect(const1.y, valve_b3[1].opening) annotation (Line(points={{73,-10},
                {70,-10},{70,8},{46,8}}, color={0,0,127}));
        annotation (
          defaultComponentName="EM",
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                  100,140}}), graphics={Text(
                extent={{26,-4},{56,-10}},
                lineColor={0,0,0},
                textString="Conditionally connected
based on exterior connections")}),
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}), graphics={
              Rectangle(
                extent={{-3.73323,6},{136.271,-6}},
                lineColor={0,0,0},
                origin={-64.2668,-40},
                rotation=0,
                fillColor={0,0,255},
                fillPattern=FillPattern.HorizontalCylinder),
              Rectangle(
                extent={{-68,46},{-20,34}},
                lineColor={0,0,0},
                fillColor={66,200,200},
                fillPattern=FillPattern.HorizontalCylinder),
              Rectangle(
                extent={{-19,6},{19,-6}},
                lineColor={0,0,0},
                origin={13,40},
                rotation=0,
                fillColor={66,200,200},
                fillPattern=FillPattern.HorizontalCylinder),
              Rectangle(
                extent={{-38,6},{19,-6}},
                lineColor={0,0,0},
                origin={23,2},
                rotation=-45,
                fillColor={66,200,200},
                fillPattern=FillPattern.HorizontalCylinder),
              Rectangle(
                extent={{34,46},{72,34}},
                lineColor={0,0,0},
                fillColor={66,200,200},
                fillPattern=FillPattern.HorizontalCylinder),
              Rectangle(
                extent={{-26,6},{26,-6}},
                lineColor={0,0,0},
                fillColor={66,200,200},
                fillPattern=FillPattern.HorizontalCylinder,
                origin={39,-42},
                rotation=90),
              Ellipse(
                extent={{24,50},{42,32}},
                lineColor={95,95,95},
                fillColor={175,175,175},
                fillPattern=FillPattern.Sphere),
              Ellipse(
                extent={{30,-4},{48,-22}},
                lineColor={95,95,95},
                fillColor={175,175,175},
                fillPattern=FillPattern.Sphere),
              Rectangle(
                extent={{34,50},{32,62}},
                lineColor={0,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.VerticalCylinder),
              Rectangle(
                extent={{40,-4},{38,8}},
                lineColor={0,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.VerticalCylinder),
              Rectangle(
                extent={{30,10},{48,8}},
                lineColor={0,0,0},
                fillColor={181,0,0},
                fillPattern=FillPattern.HorizontalCylinder),
              Rectangle(
                extent={{24,64},{42,62}},
                lineColor={0,0,0},
                fillColor={181,0,0},
                fillPattern=FillPattern.HorizontalCylinder),
              Ellipse(
                extent={{6,57},{-28,23}},
                lineColor={95,95,95},
                fillPattern=FillPattern.Sphere,
                fillColor={175,175,175}),
              Ellipse(
                extent={{35,50},{31,32}},
                lineColor={0,0,0},
                fillPattern=FillPattern.VerticalCylinder,
                fillColor={162,162,0}),
              Ellipse(
                extent={{41,-4},{37,-22}},
                lineColor={0,0,0},
                fillPattern=FillPattern.VerticalCylinder,
                fillColor={162,162,0}),
              Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Steam Manifold")}),
          experiment(StopTime=20));
      end SteamManifold_L1_valves_manual;

      model SteamManifold_L1_valves
        import NHES;
        extends
          NHES.Systems.EnergyManifold.SteamManifold.BaseClasses.Partial_SubSystem_C(
          redeclare replaceable
            NHES.Systems.EnergyManifold.SteamManifold.CS_Dummy CS(nPorts_b3=
                nPorts_b3),
          redeclare replaceable
            NHES.Systems.EnergyManifold.SteamManifold.ED_Dummy ED,
          redeclare
            NHES.Systems.EnergyManifold.SteamManifold.Data.SteamManifold data,
          redeclare final package Medium_1 = Medium,
          redeclare final package Medium_2 = Medium,
          redeclare final package Medium_3 = Medium,
          port_b2_nominal(p=port_a1_nominal.p - dp_nominal_valve_b2),
          port_b3_nominal_p={port_a1_nominal.p - dp_nominal_valve_b3[i] for i in
                  1:nPorts_b3});

        replaceable package Medium = Modelica.Media.Water.StandardWater
          constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium annotation (
            choicesAllMatching=true);

        parameter Modelica.Units.SI.PressureDifference dp_nominal_valve_b2=1e4
          "Nominal pressure drop at full opening"
          annotation (Dialog(tab="Nominal Conditions"));
        parameter Modelica.Units.SI.PressureDifference dp_nominal_valve_b3[nPorts_b3]=
           fill(1e4, nPorts_b3) "Nominal pressure drop at full opening"
          annotation (Dialog(tab="Nominal Conditions"));

        parameter Boolean use_pipeDelay_b2=false
          "=true to use include pipe effects due to distance"
          annotation (Dialog(group="port_b2 (e.g., Balance of Plant)"));
        parameter Modelica.Units.SI.Length length_b2=10
          "Length of pipe to port_b2" annotation (Dialog(group=
                "port_b2 (e.g., Balance of Plant)", enable=use_pipeDelay_b2));
        parameter Modelica.Units.SI.Diameter diameter_b2=2.5
          "Diameter of pipe to port_b2" annotation (Dialog(group=
                "port_b2 (e.g., Balance of Plant)", enable=use_pipeDelay_b2));

        parameter Boolean use_pipeDelay_a2=use_pipeDelay_b2
          "=true to use include pipe effects due to distance"
          annotation (Dialog(group="port_a2 (e.g., Balance of Plant)"));
        parameter Modelica.Units.SI.Length length_a2=length_b2
          "Length of pipe from port_a2" annotation (Dialog(group=
                "port_a2 (e.g., Balance of Plant)", enable=use_pipeDelay_b2));
        parameter Modelica.Units.SI.Diameter diameter_a2=diameter_b2
          "Diameter of pipe from port_a2" annotation (Dialog(group=
                "port_a2 (e.g., Balance of Plant)", enable=use_pipeDelay_b2));

        parameter Boolean use_pipeDelay_b3=false
          "=true to use include pipe effects due to distance"
          annotation (Dialog(group="port_b3 (e.g., Industrial Process)"));
        parameter Modelica.Units.SI.Length[nPorts_b3] length_b3=fill(10,
            nPorts_b3) "Lengtsh of pipe to port_b3" annotation (Dialog(group=
                "port_b3 (e.g., Industrial Process)", enable=use_pipeDelay_b3));
        parameter Modelica.Units.SI.Diameter[nPorts_b3] diameter_b3=fill(2.5,
            nPorts_b3) "Diameter of pipes to ports_b3" annotation (Dialog(group=
               "port_b3 (e.g., Industrial Process)", enable=use_pipeDelay_b3));

        TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(R=1,
            redeclare package Medium = Medium)
          annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
        TRANSFORM.Fluid.Volumes.MixingVolume steamHeader(
          use_T_start=false,
          nPorts_a=1,
          nPorts_b=1 + nPorts_b3,
          redeclare package Medium = Medium,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
              (V=20),
          p_start=port_a1_start.p,
          h_start=port_a1_start.h)
          annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
        TRANSFORM.Fluid.Valves.ValveIncompressible valve_b2(
          rho_nominal=Medium_1.density_ph(port_a1_nominal.p, port_a1_nominal.h),
          redeclare package Medium = Medium,
          m_flow_nominal=216,
          dp_nominal=dp_nominal_valve_b2)
          annotation (Placement(transformation(extent={{30,28},{50,48}})));
        TRANSFORM.Fluid.Valves.ValveIncompressible valve_b3[nPorts_b3](
          redeclare each package Medium = Medium,
          each rho_nominal=Medium_1.density_ph(port_a1_nominal.p, port_a1_nominal.h),
          m_flow_nominal=9,
          dp_nominal=dp_nominal_valve_b3) if
                                     nPorts_b3 > 0 annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={40,12})));

        TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_b2(
          redeclare package Medium = Medium,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
              (
              dimension=diameter_b2,
              length=length_b2,
              nV=2),
          exposeState_b=true,
          use_Ts_start=false,
          h_a_start=port_a1_start.h,
          h_b_start=port_a1_start.h,
          p_a_start=port_a1_start.p - valve_b2.dp_start,
          m_flow_a_start=-port_b2_start.m_flow)
          annotation (Placement(transformation(extent={{60,30},{80,50}})));
        TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_b3[nPorts_b3](
          redeclare package Medium = Medium,
          each exposeState_b=true,
          h_a_start=fill(port_a1_start.h, nPorts_b3),
          h_b_start=fill(port_a1_start.h, nPorts_b3),
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
              (
              each nV=2,
              dimension=diameter_b3,
              length=length_b3),
          m_flow_a_start=-port_b3_start_m_flow,
          p_a_start={port_a1_start.p - valve_b3[i].dp_start for i in 1:nPorts_b3},
          each use_Ts_start=false) if
                                     nPorts_b3 > 0 annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={40,-26})));
        TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_a2(
          redeclare package Medium = Medium,
          exposeState_b=true,
          use_Ts_start=false,
          p_a_start=port_a2_start.p,
          h_a_start=port_a2_start.h,
          h_b_start=port_a2_start.h,
          m_flow_a_start=port_a2_start.m_flow,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
              (
              nV=2,
              dimension=diameter_a2,
              length=length_a2))
          annotation (Placement(transformation(extent={{10,-50},{-10,-30}})));
      equation

        // Conditional Connections based on # of ports
        for i in 1:nPorts_b3 loop
          connect(valve_b3[i].port_a, steamHeader.port_b[i + 1]);
        end for;

        // Conditional pipe delay to port_b3
        if use_pipeDelay_b3 then
          for i in 1:nPorts_b3 loop
            connect(valve_b3[i].port_b, pipe_b3[i].port_a);
            connect(pipe_b3[i].port_b, port_b3[i]);
          end for;
        else
          for i in 1:nPorts_b3 loop
            connect(valve_b3[i].port_b, port_b3[i]);
          end for;
        end if;

        // Conditional pipe delay to port_b2
        if use_pipeDelay_b2 then
          connect(valve_b2.port_b, pipe_b2.port_a);
          connect(pipe_b2.port_b, port_b2);
        else
          connect(valve_b2.port_b, port_b2);
        end if;

        // Conditional pipe delay from port_a2
        if use_pipeDelay_a2 then
          connect(port_a2, pipe_a2.port_a);
          connect(pipe_a2.port_b, port_b1);
        else
          connect(port_a2, port_b1);
        end if;

        connect(port_a1, resistance.port_a)
          annotation (Line(points={{-100,40},{-77,40}}, color={0,127,255}));

        connect(resistance.port_b, steamHeader.port_a[1])
          annotation (Line(points={{-63,40},{-46,40}}, color={0,127,255}));
        connect(steamHeader.port_b[1], valve_b2.port_a)
          annotation (Line(points={{-34,40},{-2,40},{-2,38},{30,38}},
                                                      color={0,127,255}));
        connect(actuatorBus.opening_valve_toBOP, valve_b2.opening)
          annotation (Line(
            points={{30.1,100.1},{100,100.1},{100,60},{40,60},{40,46}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5));

        connect(actuatorBus.opening_valve_toOther, valve_b3.opening)
          annotation (Line(
            points={{30.1,100.1},{100,100.1},{100,12},{48,12}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5));

        annotation (
          defaultComponentName="EM",
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                  100,140}}), graphics={Text(
                extent={{26,-4},{56,-10}},
                lineColor={0,0,0},
                textString="Conditionally connected
based on exterior connections")}),
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}), graphics={
              Rectangle(
                extent={{-3.73323,6},{136.271,-6}},
                lineColor={0,0,0},
                origin={-64.2668,-40},
                rotation=0,
                fillColor={0,0,255},
                fillPattern=FillPattern.HorizontalCylinder),
              Rectangle(
                extent={{-68,46},{-20,34}},
                lineColor={0,0,0},
                fillColor={66,200,200},
                fillPattern=FillPattern.HorizontalCylinder),
              Rectangle(
                extent={{-19,6},{19,-6}},
                lineColor={0,0,0},
                origin={13,40},
                rotation=0,
                fillColor={66,200,200},
                fillPattern=FillPattern.HorizontalCylinder),
              Rectangle(
                extent={{-38,6},{19,-6}},
                lineColor={0,0,0},
                origin={23,2},
                rotation=-45,
                fillColor={66,200,200},
                fillPattern=FillPattern.HorizontalCylinder),
              Rectangle(
                extent={{34,46},{72,34}},
                lineColor={0,0,0},
                fillColor={66,200,200},
                fillPattern=FillPattern.HorizontalCylinder),
              Rectangle(
                extent={{-26,6},{26,-6}},
                lineColor={0,0,0},
                fillColor={66,200,200},
                fillPattern=FillPattern.HorizontalCylinder,
                origin={39,-42},
                rotation=90),
              Ellipse(
                extent={{24,50},{42,32}},
                lineColor={95,95,95},
                fillColor={175,175,175},
                fillPattern=FillPattern.Sphere),
              Ellipse(
                extent={{30,-4},{48,-22}},
                lineColor={95,95,95},
                fillColor={175,175,175},
                fillPattern=FillPattern.Sphere),
              Rectangle(
                extent={{34,50},{32,62}},
                lineColor={0,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.VerticalCylinder),
              Rectangle(
                extent={{40,-4},{38,8}},
                lineColor={0,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.VerticalCylinder),
              Rectangle(
                extent={{30,10},{48,8}},
                lineColor={0,0,0},
                fillColor={181,0,0},
                fillPattern=FillPattern.HorizontalCylinder),
              Rectangle(
                extent={{24,64},{42,62}},
                lineColor={0,0,0},
                fillColor={181,0,0},
                fillPattern=FillPattern.HorizontalCylinder),
              Ellipse(
                extent={{6,57},{-28,23}},
                lineColor={95,95,95},
                fillPattern=FillPattern.Sphere,
                fillColor={175,175,175}),
              Ellipse(
                extent={{35,50},{31,32}},
                lineColor={0,0,0},
                fillPattern=FillPattern.VerticalCylinder,
                fillColor={162,162,0}),
              Ellipse(
                extent={{41,-4},{37,-22}},
                lineColor={0,0,0},
                fillPattern=FillPattern.VerticalCylinder,
                fillColor={162,162,0}),
              Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Steam Manifold")}),
          experiment(StopTime=20));
      end SteamManifold_L1_valves;

      model IPMassflowSetpoint_BOPValveOpposingControl
        extends
          NHES.Systems.EnergyManifold.SteamManifold.BaseClasses.Partial_ControlSystem;
        parameter Modelica.Units.SI.Time delayStart=100
          "Delay start of valve control";

        parameter Integer nPorts_a3=0 "Number of port_a3 connections";
        parameter Integer nPorts_b3=0 "Number of port_b3 connections";

        parameter Modelica.Units.SI.MassFlowRate m_nominal
          "Total setpoint massflow rate from SC" annotation (Dialog(group="Inputs"));
        input Modelica.Units.SI.MassFlowRate mflow_Actual "Total massflow rate into IP"
          annotation (Dialog(group="Inputs"));
        input Modelica.Units.SI.MassFlowRate mflow_Setpoint "Total massflow rate into IP"
          annotation (Dialog(group="Inputs"));
        parameter Real gain_kBOP=1;
        parameter Real gain_kIP=1;

        Modelica.Blocks.Sources.Constant BOP_openingNominal(k=0.1)
          annotation (Placement(transformation(extent={{144,134},{164,154}})));
        Modelica.Blocks.Sources.Constant IP_openingNominal(k=0.001)
          annotation (Placement(transformation(extent={{-174,-60},{-154,-40}})));
        TRANSFORM.Controls.LimPID PID_IP_opening(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          yMax=1 -IP_openingNominal.k,
          yMin=-IP_openingNominal.k + 0.001,
          k=1,
          k_s=1,
          k_m=1)
          annotation (Placement(transformation(extent={{-12,150},{8,170}})));
        Modelica.Blocks.Math.Add IPValve_opening
          annotation (Placement(transformation(extent={{74,144},{94,164}})));
        Modelica.Blocks.Sources.RealExpression Massflow_actual_fromIP(y=mflow_Actual)
          annotation (Placement(transformation(extent={{-114,50},{-94,70}})));
        Modelica.Blocks.Sources.RealExpression Massflow_setpoint_fromSC(y=
              mflow_Setpoint)
          annotation (Placement(transformation(extent={{-106,180},{-86,200}})));
        Modelica.Blocks.Math.Feedback feedback_BPDV "set BPDV based on TDV"
          annotation (Placement(transformation(extent={{88,218},{108,198}})));
        Modelica.Blocks.Math.Max BOP_opening
          annotation (Placement(transformation(extent={{182,182},{202,202}})));
        Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
          annotation (Placement(transformation(extent={{-176,48},{-156,68}})));
        Modelica.Blocks.Sources.Constant valvedelay(k=delayStart)
          annotation (Placement(transformation(extent={{-172,182},{-152,202}})));
        Modelica.Blocks.Logical.Greater greater5
          annotation (Placement(transformation(extent={{-126,158},{-106,138}})));
        Modelica.Blocks.Logical.Switch switch_m_setpoint
          annotation (Placement(transformation(extent={{-60,58},{-40,78}})));
      equation
        connect(IP_openingNominal.y, IPValve_opening.u2) annotation (Line(points={{-153,
                -50},{50,-50},{50,148},{72,148}},
                                                color={0,0,127}));
        connect(IPValve_opening.y, actuatorBus.opening_valve_toOther[1]) annotation (
            Line(points={{95,154},{138,154},{138,-99.9},{30.1,-99.9}},color={0,0,127}),
            Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        connect(IPValve_opening.y, feedback_BPDV.u2) annotation (Line(points={{95,154},
                {130,154},{130,216},{98,216}},color={0,0,127}));
        connect(BOP_openingNominal.y, BOP_opening.u2) annotation (Line(points={{165,144},
                {172,144},{172,186},{180,186}}, color={0,0,127}));
        connect(feedback_BPDV.y, BOP_opening.u1) annotation (Line(points={{107,208},{146,
                208},{146,198},{180,198}}, color={0,0,127}));
        connect(feedback_BPDV.u1, IPValve_opening.u2) annotation (Line(points={{90,208},
                {20,208},{20,94},{50,94},{50,148},{72,148}}, color={0,0,127}));
        connect(BOP_opening.y, actuatorBus.opening_valve_toBOP) annotation (Line(
              points={{203,192},{244,192},{244,-99.9},{30.1,-99.9}}, color={0,0,127}),
            Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        connect(Massflow_setpoint_fromSC.y, PID_IP_opening.u_s) annotation (
            Line(points={{-85,190},{-76,190},{-76,160},{-14,160}},
                                                                color={0,0,127}));
        connect(PID_IP_opening.y, IPValve_opening.u1) annotation (Line(points={{9,160},
                {72,160}},                         color={0,0,127}));
        connect(clock.y, greater5.u1) annotation (Line(points={{-155,58},{-144,58},{-144,
                148},{-128,148}}, color={0,0,127}));
        connect(valvedelay.y, greater5.u2) annotation (Line(points={{-151,192},{-140,192},
                {-140,156},{-128,156}}, color={0,0,127}));
        connect(Massflow_actual_fromIP.y, switch_m_setpoint.u3)
          annotation (Line(points={{-93,60},{-62,60}}, color={0,0,127}));
        connect(greater5.y, switch_m_setpoint.u2) annotation (Line(points={{-105,148},
                {-84,148},{-84,68},{-62,68}}, color={255,0,255}));
        connect(switch_m_setpoint.u1, PID_IP_opening.u_s) annotation (Line(points={{-62,76},
                {-76,76},{-76,160},{-14,160}},     color={0,0,127}));
        connect(switch_m_setpoint.y, PID_IP_opening.u_m)
          annotation (Line(points={{-39,68},{-2,68},{-2,148}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
                  {280,280}})),                                        Diagram(
              coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{280,280}})));
      end IPMassflowSetpoint_BOPValveOpposingControl;
    end EM;

    package SupervisoryControls
      model BOP_StepDemand
        extends NHES.Systems.SupervisoryControl.BaseClasses.Partial_ControlSystem;

        parameter Real delayStart=5000 "Time to start tracking power profiles";
        parameter Modelica.Units.SI.Time timeScale=60*60
          "Time scale of first table column";

        parameter Modelica.Units.SI.Power W_nominal_BOP=4.13285e8 "Nominal BOP Power";

        input Modelica.Units.SI.Power GridDemand "Grid demand Power";

        output Modelica.Units.SI.Power W_totalSetpoint_BOP=switch_BOP.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_EG=switch_EG.y
          annotation (Dialog(group="Outputs", enable=false));

        Modelica.Blocks.Logical.LessThreshold greaterEqualThreshold1(threshold=
              delayStart)
          annotation (Placement(transformation(extent={{-118,20},{-98,40}})));
        Modelica.Blocks.Logical.Switch switch_BOP
          annotation (Placement(transformation(extent={{6,102},{26,122}})));
        Modelica.Blocks.Sources.Constant nominal_BOP(k=W_nominal_BOP)
          annotation (Placement(transformation(extent={{-46,126},{-26,146}})));

        Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
          annotation (Placement(transformation(extent={{-158,20},{-138,40}})));

        Modelica.Blocks.Logical.Switch switch_EG
          annotation (Placement(transformation(extent={{116,20},{136,40}})));
        Modelica.Blocks.Sources.Constant nominal_EG(k=nominal_BOP.k)
          annotation (Placement(transformation(extent={{36,44},{56,64}})));
        Modelica.Blocks.Sources.RealExpression BOPDemand(y=GridDemand)
          annotation (Placement(transformation(extent={{-48,50},{-28,70}})));
      equation
        connect(nominal_BOP.y, switch_BOP.u1) annotation (Line(points={{-25,136},
                {-6,136},{-6,120},{4,120}},color={0,0,127}));
        connect(clock.y, greaterEqualThreshold1.u)
          annotation (Line(points={{-137,30},{-120,30}},           color={0,0,127}));
        connect(greaterEqualThreshold1.y, switch_BOP.u2) annotation (Line(points={{-97,30},
                {-72,30},{-72,112},{4,112}},     color={255,0,255}));
        connect(nominal_EG.y,switch_EG. u1) annotation (Line(points={{57,54},{
                66,54},{66,38},{114,38}},
                                  color={0,0,127}));
        connect(switch_EG.u2, switch_BOP.u2) annotation (Line(points={{114,30},
                {-72,30},{-72,112},{4,112}},           color={255,0,255}));
        connect(BOPDemand.y, switch_BOP.u3) annotation (Line(points={{-27,60},{
                -12,60},{-12,104},{4,104}}, color={0,0,127}));
        connect(switch_EG.u3, BOPDemand.y) annotation (Line(points={{114,22},{
                -12,22},{-12,60},{-27,60}}, color={0,0,127}));
      annotation(defaultComponentName="SC", experiment(StopTime=3600,
              __Dymola_NumberOfIntervals=3600),
          Diagram(coordinateSystem(extent={{-180,-100},{160,160}})),
          Icon(coordinateSystem(extent={{-180,-100},{160,160}}), graphics={
                        Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Input Setpoints: Modelica Path")}));
      end BOP_StepDemand;

      model BOP_HTSE_StepDemand
        extends NHES.Systems.SupervisoryControl.BaseClasses.Partial_ControlSystem;

        parameter Real delayStart=5000 "Time to start tracking power profiles";
        parameter Modelica.Units.SI.Time timeScale=60*60
          "Time scale of first table column";

        parameter Modelica.Units.SI.Power W_nominal_BOP=4.13285e8 "Nominal BOP Power";
        input Modelica.Units.SI.Power Elec_Demand "Grid demand Power";

        parameter Modelica.Units.SI.Power W_IP_nom(displayUnit="MW")=51.1454e6
          "Nominal electrical power consumption in the IP";
        final parameter Modelica.Units.SI.Power W_IP_max(displayUnit="MW")=
          W_IP_nom * 1.5 "Maximum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power W_IP_min(displayUnit="MW")=20.9561e6
          "Minimum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power HTSE_Q=18.5;
        parameter Real HTSE_eff=0.35;

        output Modelica.Units.SI.Power W_totalSetpoint_BOP=switch_BOP.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_EG=switch_EG.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_IP=switch_IP.y
          annotation (Dialog(group="Outputs", enable=false));

        Modelica.Blocks.Logical.LessThreshold greaterEqualThreshold1(threshold=
              delayStart)
          annotation (Placement(transformation(extent={{-112,20},{-92,40}})));
        Modelica.Blocks.Logical.Switch switch_BOP
          annotation (Placement(transformation(extent={{2,108},{22,128}})));
        Modelica.Blocks.Sources.Constant BOP_nominal(k=W_nominal_BOP)
          annotation (Placement(transformation(extent={{-42,126},{-22,146}})));

        Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
          annotation (Placement(transformation(extent={{-164,20},{-144,40}})));

        Modelica.Blocks.Logical.Switch switch_EG
          annotation (Placement(transformation(extent={{44,18},{64,38}})));
        Modelica.Blocks.Logical.Switch switch_IP
          annotation (Placement(transformation(extent={{48,-78},{68,-58}})));
        Modelica.Blocks.Sources.Constant HTSE_nominal(k=W_IP_nom)
          annotation (Placement(transformation(extent={{-36,-54},{-16,-34}})));
        Modelica.Blocks.Sources.RealExpression IPDemand(y=BOP_nominal.y -
              HTSE_Q*HTSE_eff - GridDemand.y)
          annotation (Placement(transformation(extent={{-74,-110},{-54,-90}})));
        Modelica.Blocks.Sources.RealExpression BOPDemand(y=GridDemand.y +
              limiter_HTSE_W.y)
          annotation (Placement(transformation(extent={{-38,94},{-18,114}})));
        Modelica.Blocks.Nonlinear.Limiter limiter_HTSE_W(uMax=W_IP_max, uMin=W_IP_min)
          annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={-12,-94})));
        Modelica.Blocks.Sources.RealExpression Grid_nominal(y=BOP_nominal.y -
              HTSE_nominal.y)
          annotation (Placement(transformation(extent={{-36,44},{-16,64}})));
        Modelica.Blocks.Sources.RealExpression GridDemand(y=Elec_Demand)
          annotation (Placement(transformation(extent={{-38,0},{-18,20}})));
      equation
        connect(BOP_nominal.y, switch_BOP.u1) annotation (Line(points={{-21,136},{-6,136},
                {-6,126},{0,126}},         color={0,0,127}));
        connect(clock.y, greaterEqualThreshold1.u)
          annotation (Line(points={{-143,30},{-114,30}},           color={0,0,127}));
        connect(greaterEqualThreshold1.y, switch_BOP.u2) annotation (Line(points={{-91,30},
                {-72,30},{-72,118},{0,118}},     color={255,0,255}));
        connect(switch_EG.u2, switch_BOP.u2) annotation (Line(points={{42,28},{-72,28},
                {-72,118},{0,118}},                    color={255,0,255}));
        connect(switch_IP.u2, switch_BOP.u2) annotation (Line(points={{46,-68},{-72,-68},
                {-72,118},{0,118}}, color={255,0,255}));
        connect(HTSE_nominal.y, switch_IP.u1) annotation (Line(points={{-15,-44},{30,-44},
                {30,-60},{46,-60}}, color={0,0,127}));
        connect(BOPDemand.y, switch_BOP.u3) annotation (Line(points={{-17,104},
                {-10,104},{-10,110},{0,110}},
                                    color={0,0,127}));
        connect(IPDemand.y, limiter_HTSE_W.u)
          annotation (Line(points={{-53,-100},{-42,-100},{-42,-94},{-24,-94}},
                                                         color={0,0,127}));
        connect(limiter_HTSE_W.y, switch_IP.u3) annotation (Line(points={{-1,-94},
                {30,-94},{30,-76},{46,-76}},
                                         color={0,0,127}));
        connect(Grid_nominal.y, switch_EG.u1) annotation (Line(points={{-15,54},{14,54},
                {14,36},{42,36}}, color={0,0,127}));
        connect(GridDemand.y, switch_EG.u3) annotation (Line(points={{-17,10},{16,10},
                {16,20},{42,20}},color={0,0,127}));
      annotation(defaultComponentName="SC", experiment(StopTime=3600,
              __Dymola_NumberOfIntervals=3600),
          Diagram(coordinateSystem(extent={{-180,-160},{160,160}})),
          Icon(coordinateSystem(extent={{-180,-160},{160,160}}), graphics={
                        Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Input Setpoints: Modelica Path")}));
      end BOP_HTSE_StepDemand;

      model Wind_BOP_IP_StepDemand
        extends NHES.Systems.SupervisoryControl.BaseClasses.Partial_ControlSystem;

        parameter Real delayStart=5000 "Time to start tracking power profiles";
        parameter Modelica.Units.SI.Time timeScale=60*60
          "Time scale of first table column";

        parameter Modelica.Units.SI.Power W_nominal_BOP=4.13285e8 "Nominal BOP Power";

        parameter Modelica.Units.SI.Power W_IP_nom(displayUnit="MW")=51.1454e6
          "Nominal electrical power consumption in the IP";
        final parameter Modelica.Units.SI.Power W_IP_max(displayUnit="MW")=
          W_IP_nom "Maximum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power W_IP_min(displayUnit="MW")=20.9561e6
          "Minimum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power HTSE_Q=18.5;
        parameter Real HTSE_eff=0.35;

        input Modelica.Units.SI.Power Elec_Demand "Grid demand Power";
        input Modelica.Units.SI.Power Wind_Power "Wind power";

        output Modelica.Units.SI.Power W_totalSetpoint_BOP=switch_BOP.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_EG=switch_EG.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_IP=switch_IP.y
          annotation (Dialog(group="Outputs", enable=false));

        Modelica.Blocks.Logical.LessThreshold greaterEqualThreshold1(threshold=
              delayStart)
          annotation (Placement(transformation(extent={{-112,18},{-92,38}})));
        Modelica.Blocks.Logical.Switch switch_BOP
          annotation (Placement(transformation(extent={{2,108},{22,128}})));
        Modelica.Blocks.Sources.Constant BOP_nominal(k=W_nominal_BOP)
          annotation (Placement(transformation(extent={{-44,132},{-24,152}})));

        Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
          annotation (Placement(transformation(extent={{-160,18},{-140,38}})));

        Modelica.Blocks.Logical.Switch switch_EG
          annotation (Placement(transformation(extent={{44,18},{64,38}})));
        Modelica.Blocks.Logical.Switch switch_IP
          annotation (Placement(transformation(extent={{48,-78},{68,-58}})));
        Modelica.Blocks.Sources.Constant HTSE_nominal(k=W_IP_nom)
          annotation (Placement(transformation(extent={{-36,-54},{-16,-34}})));
        Modelica.Blocks.Sources.RealExpression IPDemand(y=BOP_nominal.y + Wind_Power -
              HTSE_Q*HTSE_eff - GridDemand.y)
          annotation (Placement(transformation(extent={{-72,-120},{-52,-100}})));
        Modelica.Blocks.Sources.RealExpression BOPDemand(y=GridDemand.y +
              limiter_HTSE_W.y - Wind_Power)
          annotation (Placement(transformation(extent={{-46,94},{-26,114}})));
        Modelica.Blocks.Nonlinear.Limiter limiter_HTSE_W(uMax=W_IP_max, uMin=W_IP_min)
          annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={-12,-94})));
        Modelica.Blocks.Sources.RealExpression Grid_nominal(y=BOP_nominal.y -
              HTSE_nominal.y)
          annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
        Modelica.Blocks.Sources.RealExpression GridDemand(y=Elec_Demand)
          annotation (Placement(transformation(extent={{-46,-2},{-26,18}})));
      equation
        connect(BOP_nominal.y, switch_BOP.u1) annotation (Line(points={{-23,142},{-6,142},
                {-6,126},{0,126}},         color={0,0,127}));
        connect(clock.y, greaterEqualThreshold1.u)
          annotation (Line(points={{-139,28},{-114,28}},           color={0,0,127}));
        connect(greaterEqualThreshold1.y, switch_BOP.u2) annotation (Line(points={{-91,28},
                {-72,28},{-72,118},{0,118}},     color={255,0,255}));
        connect(switch_EG.u2, switch_BOP.u2) annotation (Line(points={{42,28},{-72,28},
                {-72,118},{0,118}},                    color={255,0,255}));
        connect(switch_IP.u2, switch_BOP.u2) annotation (Line(points={{46,-68},{-72,-68},
                {-72,118},{0,118}}, color={255,0,255}));
        connect(HTSE_nominal.y, switch_IP.u1) annotation (Line(points={{-15,-44},{30,-44},
                {30,-60},{46,-60}}, color={0,0,127}));
        connect(BOPDemand.y, switch_BOP.u3) annotation (Line(points={{-25,104},{-10,104},
                {-10,110},{0,110}}, color={0,0,127}));
        connect(IPDemand.y, limiter_HTSE_W.u)
          annotation (Line(points={{-51,-110},{-42,-110},{-42,-94},{-24,-94}},
                                                         color={0,0,127}));
        connect(limiter_HTSE_W.y, switch_IP.u3) annotation (Line(points={{-1,-94},
                {30,-94},{30,-76},{46,-76}},
                                         color={0,0,127}));
        connect(Grid_nominal.y, switch_EG.u1) annotation (Line(points={{-25,60},{14,60},
                {14,36},{42,36}}, color={0,0,127}));
        connect(GridDemand.y, switch_EG.u3) annotation (Line(points={{-25,8},{16,8},{16,
                20},{42,20}},    color={0,0,127}));
      annotation(defaultComponentName="SC", experiment(StopTime=3600,
              __Dymola_NumberOfIntervals=3600),
          Diagram(coordinateSystem(extent={{-180,-160},{160,160}})),
          Icon(coordinateSystem(extent={{-180,-160},{160,160}}), graphics={
                        Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Input Setpoints: Modelica Path")}));
      end Wind_BOP_IP_StepDemand;

      model Wind_BOP_StepDemand
        extends NHES.Systems.SupervisoryControl.BaseClasses.Partial_ControlSystem;

        parameter Real delayStart=5000 "Time to start tracking power profiles";
        parameter Modelica.Units.SI.Time timeScale=60*60
          "Time scale of first table column";

        parameter Modelica.Units.SI.Power W_nominal_BOP=4.13285e8 "Nominal BOP Power";

        input Modelica.Units.SI.Power Elec_Demand "Grid demand Power";
        input Modelica.Units.SI.Power Wind_Power;

        output Modelica.Units.SI.Power W_totalSetpoint_BOP=switch_BOP.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_EG=switch_EG.y
          annotation (Dialog(group="Outputs", enable=false));

        Modelica.Blocks.Logical.LessThreshold greaterEqualThreshold1(threshold=
              delayStart)
          annotation (Placement(transformation(extent={{-112,18},{-92,38}})));
        Modelica.Blocks.Logical.Switch switch_BOP
          annotation (Placement(transformation(extent={{2,108},{22,128}})));
        Modelica.Blocks.Sources.Constant BOP_nominal(k=W_nominal_BOP)
          annotation (Placement(transformation(extent={{-42,128},{-22,148}})));

        Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
          annotation (Placement(transformation(extent={{-160,18},{-140,38}})));

        Modelica.Blocks.Logical.Switch switch_EG
          annotation (Placement(transformation(extent={{44,18},{64,38}})));
        Modelica.Blocks.Sources.RealExpression BOPDemand(y=GridDemand.y - Wind_Power)
          annotation (Placement(transformation(extent={{-46,92},{-26,112}})));
        Modelica.Blocks.Sources.RealExpression Grid_nominal(y=BOP_nominal.y)
          annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
        Modelica.Blocks.Sources.RealExpression GridDemand(y=Elec_Demand)
          annotation (Placement(transformation(extent={{-42,-2},{-22,18}})));
      equation
        connect(BOP_nominal.y, switch_BOP.u1) annotation (Line(points={{-21,138},{-6,138},
                {-6,126},{0,126}},         color={0,0,127}));
        connect(clock.y, greaterEqualThreshold1.u)
          annotation (Line(points={{-139,28},{-114,28}},           color={0,0,127}));
        connect(greaterEqualThreshold1.y, switch_BOP.u2) annotation (Line(points={{-91,28},
                {-72,28},{-72,118},{0,118}},     color={255,0,255}));
        connect(switch_EG.u2, switch_BOP.u2) annotation (Line(points={{42,28},{-72,28},
                {-72,118},{0,118}},                    color={255,0,255}));
        connect(BOPDemand.y, switch_BOP.u3) annotation (Line(points={{-25,102},{-10,102},
                {-10,110},{0,110}}, color={0,0,127}));
        connect(Grid_nominal.y, switch_EG.u1) annotation (Line(points={{-25,60},{14,60},
                {14,36},{42,36}}, color={0,0,127}));
        connect(GridDemand.y, switch_EG.u3) annotation (Line(points={{-21,8},{16,8},{16,
                20},{42,20}},    color={0,0,127}));
      annotation(defaultComponentName="SC", experiment(StopTime=3600,
              __Dymola_NumberOfIntervals=3600),
          Diagram(coordinateSystem(extent={{-180,-160},{160,160}})),
          Icon(coordinateSystem(extent={{-180,-160},{160,160}}), graphics={
                        Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Input Setpoints: Modelica Path")}));
      end Wind_BOP_StepDemand;

      model Solar_BOP_StepDemand
        extends NHES.Systems.SupervisoryControl.BaseClasses.Partial_ControlSystem;

        parameter Real delayStart=5000 "Time to start tracking power profiles";
        parameter Modelica.Units.SI.Time timeScale=60*60
          "Time scale of first table column";

        parameter Modelica.Units.SI.Power W_nominal_BOP=4.13285e8 "Nominal BOP Power";

        input Modelica.Units.SI.Power Elec_Demand "Grid demand Power";
        input Modelica.Units.SI.Power Solar_Power;

        output Modelica.Units.SI.Power W_totalSetpoint_BOP=switch_BOP.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_EG=switch_EG.y
          annotation (Dialog(group="Outputs", enable=false));

        Modelica.Blocks.Logical.LessThreshold greaterEqualThreshold1(threshold=
              delayStart)
          annotation (Placement(transformation(extent={{-112,18},{-92,38}})));
        Modelica.Blocks.Logical.Switch switch_BOP
          annotation (Placement(transformation(extent={{2,108},{22,128}})));
        Modelica.Blocks.Sources.Constant BOP_nominal(k=W_nominal_BOP)
          annotation (Placement(transformation(extent={{-42,128},{-22,148}})));

        Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
          annotation (Placement(transformation(extent={{-160,18},{-140,38}})));

        Modelica.Blocks.Logical.Switch switch_EG
          annotation (Placement(transformation(extent={{44,18},{64,38}})));
        Modelica.Blocks.Sources.RealExpression BOPDemand(y=GridDemand.y - Solar_Power)
          annotation (Placement(transformation(extent={{-42,92},{-22,112}})));
        Modelica.Blocks.Sources.RealExpression Grid_nominal(y=BOP_nominal.y)
          annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
        Modelica.Blocks.Sources.RealExpression GridDemand(y=Elec_Demand)
          annotation (Placement(transformation(extent={{-46,-4},{-26,16}})));
      equation
        connect(BOP_nominal.y, switch_BOP.u1) annotation (Line(points={{-21,138},{-6,138},
                {-6,126},{0,126}},         color={0,0,127}));
        connect(clock.y, greaterEqualThreshold1.u)
          annotation (Line(points={{-139,28},{-114,28}},           color={0,0,127}));
        connect(greaterEqualThreshold1.y, switch_BOP.u2) annotation (Line(points={{-91,28},
                {-72,28},{-72,118},{0,118}},     color={255,0,255}));
        connect(switch_EG.u2, switch_BOP.u2) annotation (Line(points={{42,28},{-72,28},
                {-72,118},{0,118}},                    color={255,0,255}));
        connect(BOPDemand.y, switch_BOP.u3) annotation (Line(points={{-21,102},{-10,102},
                {-10,110},{0,110}}, color={0,0,127}));
        connect(Grid_nominal.y, switch_EG.u1) annotation (Line(points={{-25,60},{14,60},
                {14,36},{42,36}}, color={0,0,127}));
        connect(GridDemand.y, switch_EG.u3) annotation (Line(points={{-25,6},{16,6},{16,
                20},{42,20}},    color={0,0,127}));
      annotation(defaultComponentName="SC", experiment(StopTime=3600,
              __Dymola_NumberOfIntervals=3600),
          Diagram(coordinateSystem(extent={{-180,-160},{160,160}})),
          Icon(coordinateSystem(extent={{-180,-160},{160,160}}), graphics={
                        Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Input Setpoints: Modelica Path")}));
      end Solar_BOP_StepDemand;

      model Solar_BOP_IP_StepDemand
        extends NHES.Systems.SupervisoryControl.BaseClasses.Partial_ControlSystem;

        parameter Real delayStart=5000 "Time to start tracking power profiles";
        parameter Modelica.Units.SI.Time timeScale=60*60
          "Time scale of first table column";

        parameter Modelica.Units.SI.Power W_nominal_BOP=4.13285e8 "Nominal BOP Power";

        parameter Modelica.Units.SI.Power W_IP_nom(displayUnit="MW")=51.1454e6
          "Nominal electrical power consumption in the IP";
        final parameter Modelica.Units.SI.Power W_IP_max(displayUnit="MW")=
          W_IP_nom "Maximum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power W_IP_min(displayUnit="MW")=20.9561e6
          "Minimum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power HTSE_Q=18.5;
        parameter Real HTSE_eff=0.35;

        input Modelica.Units.SI.Power Elec_Demand "Grid demand Power";
        input Modelica.Units.SI.Power Solar_Power "Wind power";

        output Modelica.Units.SI.Power W_totalSetpoint_BOP=switch_BOP.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_EG=switch_EG.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_IP=switch_IP.y
          annotation (Dialog(group="Outputs", enable=false));

        Modelica.Blocks.Logical.LessThreshold greaterEqualThreshold1(threshold=
              delayStart)
          annotation (Placement(transformation(extent={{-112,18},{-92,38}})));
        Modelica.Blocks.Logical.Switch switch_BOP
          annotation (Placement(transformation(extent={{2,108},{22,128}})));
        Modelica.Blocks.Sources.Constant BOP_nominal(k=W_nominal_BOP)
          annotation (Placement(transformation(extent={{-44,132},{-24,152}})));

        Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
          annotation (Placement(transformation(extent={{-160,18},{-140,38}})));

        Modelica.Blocks.Logical.Switch switch_EG
          annotation (Placement(transformation(extent={{44,18},{64,38}})));
        Modelica.Blocks.Logical.Switch switch_IP
          annotation (Placement(transformation(extent={{48,-78},{68,-58}})));
        Modelica.Blocks.Sources.Constant HTSE_nominal(k=W_IP_nom)
          annotation (Placement(transformation(extent={{-36,-54},{-16,-34}})));
        Modelica.Blocks.Sources.RealExpression IPDemand(y=BOP_nominal.y + Solar_Power -
              HTSE_Q*HTSE_eff - GridDemand.y)
          annotation (Placement(transformation(extent={{-72,-120},{-52,-100}})));
        Modelica.Blocks.Sources.RealExpression BOPDemand(y=GridDemand.y +
              limiter_HTSE_W.y - Solar_Power)
          annotation (Placement(transformation(extent={{-46,94},{-26,114}})));
        Modelica.Blocks.Nonlinear.Limiter limiter_HTSE_W(uMax=W_IP_max, uMin=W_IP_min)
          annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={-12,-94})));
        Modelica.Blocks.Sources.RealExpression Grid_nominal(y=BOP_nominal.y -
              HTSE_nominal.y)
          annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
        Modelica.Blocks.Sources.RealExpression GridDemand(y=Elec_Demand)
          annotation (Placement(transformation(extent={{-46,-2},{-26,18}})));
      equation
        connect(BOP_nominal.y, switch_BOP.u1) annotation (Line(points={{-23,142},{-6,142},
                {-6,126},{0,126}},         color={0,0,127}));
        connect(clock.y, greaterEqualThreshold1.u)
          annotation (Line(points={{-139,28},{-114,28}},           color={0,0,127}));
        connect(greaterEqualThreshold1.y, switch_BOP.u2) annotation (Line(points={{-91,28},
                {-72,28},{-72,118},{0,118}},     color={255,0,255}));
        connect(switch_EG.u2, switch_BOP.u2) annotation (Line(points={{42,28},{-72,28},
                {-72,118},{0,118}},                    color={255,0,255}));
        connect(switch_IP.u2, switch_BOP.u2) annotation (Line(points={{46,-68},{-72,-68},
                {-72,118},{0,118}}, color={255,0,255}));
        connect(HTSE_nominal.y, switch_IP.u1) annotation (Line(points={{-15,-44},{30,-44},
                {30,-60},{46,-60}}, color={0,0,127}));
        connect(BOPDemand.y, switch_BOP.u3) annotation (Line(points={{-25,104},{-10,104},
                {-10,110},{0,110}}, color={0,0,127}));
        connect(IPDemand.y, limiter_HTSE_W.u)
          annotation (Line(points={{-51,-110},{-42,-110},{-42,-94},{-24,-94}},
                                                         color={0,0,127}));
        connect(limiter_HTSE_W.y, switch_IP.u3) annotation (Line(points={{-1,-94},
                {30,-94},{30,-76},{46,-76}},
                                         color={0,0,127}));
        connect(Grid_nominal.y, switch_EG.u1) annotation (Line(points={{-25,60},{14,60},
                {14,36},{42,36}}, color={0,0,127}));
        connect(GridDemand.y, switch_EG.u3) annotation (Line(points={{-25,8},{16,8},{16,
                20},{42,20}},    color={0,0,127}));
      annotation(defaultComponentName="SC", experiment(StopTime=3600,
              __Dymola_NumberOfIntervals=3600),
          Diagram(coordinateSystem(extent={{-180,-160},{160,160}})),
          Icon(coordinateSystem(extent={{-180,-160},{160,160}}), graphics={
                        Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Input Setpoints: Modelica Path")}));
      end Solar_BOP_IP_StepDemand;

      model BOP_DailyDemand
        extends NHES.Systems.SupervisoryControl.BaseClasses.Partial_ControlSystem;

        parameter Real delayStart=10 "Time to start tracking power profiles";
        parameter Modelica.Units.SI.Time timeScale=60*60
          "Time scale of first table column";

        parameter Modelica.Units.SI.Power W_nominal_BOP=7.0185e8 "Nominal BOP Power";


        output Modelica.Units.SI.Power W_totalSetpoint_BOP=switch_BOP.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_EG=switch_EG.y
          annotation (Dialog(group="Outputs", enable=false));
        parameter String fileName=Modelica.Utilities.Files.loadResource(
            "C:/Users/raj180002/Documents/Dymola/Journal_NHES_Data/Demand/Jan1_24_Elec.txt")
          "File where matrix is stored";
        Modelica.Blocks.Logical.LessThreshold greaterEqualThreshold1(threshold=
              delayStart)
          annotation (Placement(transformation(extent={{-118,20},{-98,40}})));
        Modelica.Blocks.Logical.Switch switch_BOP
          annotation (Placement(transformation(extent={{26,108},{46,128}})));
        Modelica.Blocks.Sources.Constant nominal_BOP(k=W_nominal_BOP)
          annotation (Placement(transformation(extent={{-40,128},{-20,148}})));

        Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
          annotation (Placement(transformation(extent={{-158,20},{-138,40}})));

        Modelica.Blocks.Logical.Switch switch_EG
          annotation (Placement(transformation(extent={{116,20},{136,40}})));
        Modelica.Blocks.Sources.Constant nominal_EG(k=nominal_BOP.k)
          annotation (Placement(transformation(extent={{36,44},{56,64}})));
        Modelica.Blocks.Sources.CombiTimeTable demand_EG(
          tableOnFile=true,
          timeScale=timeScale,
          startTime=delayStart,
          tableName="Grid",
          fileName=fileName)
          annotation (Placement(transformation(extent={{-66,54},{-46,74}})));
        Modelica.Blocks.Math.Gain gain(k=W_nominal_BOP)
          annotation (Placement(transformation(extent={{-28,54},{-8,74}})));
      equation
        connect(nominal_BOP.y, switch_BOP.u1) annotation (Line(points={{-19,138},{-6,138},
                {-6,126},{24,126}},        color={0,0,127}));
        connect(clock.y, greaterEqualThreshold1.u)
          annotation (Line(points={{-137,30},{-120,30}},           color={0,0,127}));
        connect(greaterEqualThreshold1.y, switch_BOP.u2) annotation (Line(points={{-97,30},
                {-72,30},{-72,118},{24,118}},    color={255,0,255}));
        connect(nominal_EG.y,switch_EG. u1) annotation (Line(points={{57,54},{
                66,54},{66,38},{114,38}},
                                  color={0,0,127}));
        connect(switch_EG.u2, switch_BOP.u2) annotation (Line(points={{114,30},{-72,30},
                {-72,118},{24,118}},                   color={255,0,255}));
        connect(demand_EG.y[1], gain.u)
          annotation (Line(points={{-45,64},{-30,64}}, color={0,0,127}));
        connect(gain.y, switch_BOP.u3) annotation (Line(points={{-7,64},{0,64},{0,110},
                {24,110}},color={0,0,127}));
        connect(switch_EG.u3, switch_BOP.u3) annotation (Line(points={{114,22},{0,22},
                {0,110},{24,110}},color={0,0,127}));
      annotation(defaultComponentName="SC", experiment(StopTime=3600,
              __Dymola_NumberOfIntervals=3600),
          Diagram(coordinateSystem(extent={{-180,-100},{160,160}})),
          Icon(coordinateSystem(extent={{-180,-100},{160,160}}), graphics={
                        Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Input Setpoints: Modelica Path")}));
      end BOP_DailyDemand;

      model Wind_BOP_IP_DailyDemand
        extends NHES.Systems.SupervisoryControl.BaseClasses.Partial_ControlSystem;

        parameter Real delayStart=5000 "Time to start tracking power profiles";
        parameter Modelica.Units.SI.Time timeScale=1800
          "Time scale of first table column";

        parameter Modelica.Units.SI.Power W_nominal_BOP=4.13285e8 "Nominal BOP Power";

        parameter Modelica.Units.SI.Power W_IP_nom(displayUnit="MW")=51.1454e6
          "Nominal electrical power consumption in the IP";
        final parameter Modelica.Units.SI.Power W_IP_max(displayUnit="MW")=
          W_IP_nom "Maximum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power W_IP_min(displayUnit="MW")=20.9561e6
          "Minimum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power HTSE_Q=18.5;
        parameter Real HTSE_eff=0.35;

        input Modelica.Units.SI.Power Wind_Power "Wind power";

        output Modelica.Units.SI.Power W_totalSetpoint_BOP=switch_BOP.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_EG=switch_EG.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_IP=switch_IP.y
          annotation (Dialog(group="Outputs", enable=false));
        parameter String fileName=Modelica.Utilities.Files.loadResource(
            "C:/Users/raj180002/OneDrive - The University of Texas at Dallas/Dymola/Journal_NHES_Data/Demand/May_24_Wind.txt")
          "File where matrix is stored";

        Modelica.Blocks.Logical.LessThreshold greaterEqualThreshold1(threshold=
              delayStart)
          annotation (Placement(transformation(extent={{-112,18},{-92,38}})));
        Modelica.Blocks.Logical.Switch switch_BOP
          annotation (Placement(transformation(extent={{2,108},{22,128}})));
        Modelica.Blocks.Sources.Constant BOP_nominal(k=W_nominal_BOP)
          annotation (Placement(transformation(extent={{-44,132},{-24,152}})));

        Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
          annotation (Placement(transformation(extent={{-160,18},{-140,38}})));

        Modelica.Blocks.Logical.Switch switch_EG
          annotation (Placement(transformation(extent={{44,18},{64,38}})));
        Modelica.Blocks.Logical.Switch switch_IP
          annotation (Placement(transformation(extent={{48,-78},{68,-58}})));
        Modelica.Blocks.Sources.Constant HTSE_nominal(k=W_IP_nom)
          annotation (Placement(transformation(extent={{-36,-54},{-16,-34}})));
        Modelica.Blocks.Sources.RealExpression IPDemand(y=BOP_nominal.y + Wind_Power -
              HTSE_Q*HTSE_eff - GridDemand.y)
          annotation (Placement(transformation(extent={{-72,-120},{-52,-100}})));
        Modelica.Blocks.Sources.RealExpression BOPDemand(y=GridDemand.y +
              limiter_HTSE_W.y - Wind_Power)
          annotation (Placement(transformation(extent={{-46,94},{-26,114}})));
        Modelica.Blocks.Nonlinear.Limiter limiter_HTSE_W(uMax=W_IP_max, uMin=W_IP_min)
          annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={-12,-94})));
        Modelica.Blocks.Sources.RealExpression Grid_nominal(y=BOP_nominal.y -
              HTSE_nominal.y)
          annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
        Modelica.Blocks.Sources.CombiTimeTable demand_EG(
          tableOnFile=true,
          timeScale=timeScale,
          startTime=delayStart,
          tableName="Grid",
          fileName=fileName)
          annotation (Placement(transformation(extent={{-54,-6},{-34,14}})));
        Modelica.Blocks.Math.Gain GridDemand(k=1.71e08)
          annotation (Placement(transformation(extent={{-16,-6},{4,14}})));
      equation
        connect(BOP_nominal.y, switch_BOP.u1) annotation (Line(points={{-23,142},{-6,142},
                {-6,126},{0,126}},         color={0,0,127}));
        connect(clock.y, greaterEqualThreshold1.u)
          annotation (Line(points={{-139,28},{-114,28}},           color={0,0,127}));
        connect(greaterEqualThreshold1.y, switch_BOP.u2) annotation (Line(points={{-91,28},
                {-72,28},{-72,118},{0,118}},     color={255,0,255}));
        connect(switch_EG.u2, switch_BOP.u2) annotation (Line(points={{42,28},{-72,28},
                {-72,118},{0,118}},                    color={255,0,255}));
        connect(switch_IP.u2, switch_BOP.u2) annotation (Line(points={{46,-68},{-72,-68},
                {-72,118},{0,118}}, color={255,0,255}));
        connect(HTSE_nominal.y, switch_IP.u1) annotation (Line(points={{-15,-44},{30,-44},
                {30,-60},{46,-60}}, color={0,0,127}));
        connect(BOPDemand.y, switch_BOP.u3) annotation (Line(points={{-25,104},{-10,104},
                {-10,110},{0,110}}, color={0,0,127}));
        connect(IPDemand.y, limiter_HTSE_W.u)
          annotation (Line(points={{-51,-110},{-42,-110},{-42,-94},{-24,-94}},
                                                         color={0,0,127}));
        connect(limiter_HTSE_W.y, switch_IP.u3) annotation (Line(points={{-1,-94},
                {30,-94},{30,-76},{46,-76}},
                                         color={0,0,127}));
        connect(Grid_nominal.y, switch_EG.u1) annotation (Line(points={{-25,60},{14,60},
                {14,36},{42,36}}, color={0,0,127}));
        connect(demand_EG.y[1], GridDemand.u)
          annotation (Line(points={{-33,4},{-18,4}}, color={0,0,127}));
        connect(GridDemand.y, switch_EG.u3)
          annotation (Line(points={{5,4},{24,4},{24,20},{42,20}}, color={0,0,127}));
      annotation(defaultComponentName="SC", experiment(
            StopTime=86400,
            __Dymola_NumberOfIntervals=3600,
            __Dymola_Algorithm="Dassl"),
          Diagram(coordinateSystem(extent={{-180,-160},{160,160}})),
          Icon(coordinateSystem(extent={{-180,-160},{160,160}}), graphics={
                        Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Input Setpoints: Modelica Path")}));
      end Wind_BOP_IP_DailyDemand;

      model BOP_HTSE_DailyDemand
        extends NHES.Systems.SupervisoryControl.BaseClasses.Partial_ControlSystem;

        parameter Real delayStart=5000 "Time to start tracking power profiles";
        parameter Modelica.Units.SI.Time timeScale=60*60
          "Time scale of first table column";

        parameter Modelica.Units.SI.Power W_nominal_BOP=4.13285e8 "Nominal BOP Power";

        parameter Modelica.Units.SI.Power W_IP_nom(displayUnit="MW")=51.1454e6
          "Nominal electrical power consumption in the IP";
        final parameter Modelica.Units.SI.Power W_IP_max(displayUnit="MW")=
          W_IP_nom * 1.5 "Maximum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power W_IP_min(displayUnit="MW")=20.9561e6
          "Minimum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power HTSE_Q=18.5;
        parameter Real HTSE_eff=0.35;

        output Modelica.Units.SI.Power W_totalSetpoint_BOP=switch_BOP.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_EG=switch_EG.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_IP=switch_IP.y
          annotation (Dialog(group="Outputs", enable=false));
        parameter String fileName=Modelica.Utilities.Files.loadResource(
            "C:/Users/raj180002/Documents/Dymola/Journal_NHES_Data/Demand/May_24_Wind.txt")
          "File where matrix is stored";

        Modelica.Blocks.Logical.LessThreshold greaterEqualThreshold1(threshold=
              delayStart)
          annotation (Placement(transformation(extent={{-112,20},{-92,40}})));
        Modelica.Blocks.Logical.Switch switch_BOP
          annotation (Placement(transformation(extent={{2,108},{22,128}})));
        Modelica.Blocks.Sources.Constant BOP_nominal(k=W_nominal_BOP)
          annotation (Placement(transformation(extent={{-42,126},{-22,146}})));

        Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
          annotation (Placement(transformation(extent={{-164,20},{-144,40}})));

        Modelica.Blocks.Logical.Switch switch_EG
          annotation (Placement(transformation(extent={{44,18},{64,38}})));
        Modelica.Blocks.Logical.Switch switch_IP
          annotation (Placement(transformation(extent={{48,-78},{68,-58}})));
        Modelica.Blocks.Sources.Constant HTSE_nominal(k=W_IP_nom)
          annotation (Placement(transformation(extent={{-36,-54},{-16,-34}})));
        Modelica.Blocks.Sources.RealExpression IPDemand(y=BOP_nominal.y -
              HTSE_Q*HTSE_eff - GridDemand.y)
          annotation (Placement(transformation(extent={{-74,-110},{-54,-90}})));
        Modelica.Blocks.Sources.RealExpression BOPDemand(y=GridDemand.y +
              limiter_HTSE_W.y)
          annotation (Placement(transformation(extent={{-38,94},{-18,114}})));
        Modelica.Blocks.Nonlinear.Limiter limiter_HTSE_W(uMax=W_IP_max, uMin=W_IP_min)
          annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={-12,-94})));
        Modelica.Blocks.Sources.RealExpression Grid_nominal(y=BOP_nominal.y -
              HTSE_nominal.y)
          annotation (Placement(transformation(extent={{-36,44},{-16,64}})));
        Modelica.Blocks.Sources.CombiTimeTable demand_EG(
          tableOnFile=true,
          timeScale=timeScale,
          startTime=delayStart,
          tableName="Grid",
          fileName=fileName)
          annotation (Placement(transformation(extent={{-42,-8},{-22,12}})));
        Modelica.Blocks.Math.Gain GridDemand(k=143e06)
          annotation (Placement(transformation(extent={{-4,-8},{16,12}})));
      equation
        connect(BOP_nominal.y, switch_BOP.u1) annotation (Line(points={{-21,136},{-6,136},
                {-6,126},{0,126}},         color={0,0,127}));
        connect(clock.y, greaterEqualThreshold1.u)
          annotation (Line(points={{-143,30},{-114,30}},           color={0,0,127}));
        connect(greaterEqualThreshold1.y, switch_BOP.u2) annotation (Line(points={{-91,30},
                {-72,30},{-72,118},{0,118}},     color={255,0,255}));
        connect(switch_EG.u2, switch_BOP.u2) annotation (Line(points={{42,28},{-72,28},
                {-72,118},{0,118}},                    color={255,0,255}));
        connect(switch_IP.u2, switch_BOP.u2) annotation (Line(points={{46,-68},{-72,-68},
                {-72,118},{0,118}}, color={255,0,255}));
        connect(HTSE_nominal.y, switch_IP.u1) annotation (Line(points={{-15,-44},{30,-44},
                {30,-60},{46,-60}}, color={0,0,127}));
        connect(BOPDemand.y, switch_BOP.u3) annotation (Line(points={{-17,104},
                {-10,104},{-10,110},{0,110}},
                                    color={0,0,127}));
        connect(IPDemand.y, limiter_HTSE_W.u)
          annotation (Line(points={{-53,-100},{-42,-100},{-42,-94},{-24,-94}},
                                                         color={0,0,127}));
        connect(limiter_HTSE_W.y, switch_IP.u3) annotation (Line(points={{-1,-94},
                {30,-94},{30,-76},{46,-76}},
                                         color={0,0,127}));
        connect(Grid_nominal.y, switch_EG.u1) annotation (Line(points={{-15,54},{14,54},
                {14,36},{42,36}}, color={0,0,127}));
        connect(demand_EG.y[1], GridDemand.u)
          annotation (Line(points={{-21,2},{-6,2}}, color={0,0,127}));
        connect(GridDemand.y, switch_EG.u3)
          annotation (Line(points={{17,2},{28,2},{28,20},{42,20}}, color={0,0,127}));
      annotation(defaultComponentName="SC", experiment(StopTime=3600,
              __Dymola_NumberOfIntervals=3600),
          Diagram(coordinateSystem(extent={{-180,-160},{160,160}})),
          Icon(coordinateSystem(extent={{-180,-160},{160,160}}), graphics={
                        Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Input Setpoints: Modelica Path")}));
      end BOP_HTSE_DailyDemand;

      model Solar_BOP_IP_DailyDemand
        extends NHES.Systems.SupervisoryControl.BaseClasses.Partial_ControlSystem;

        parameter Real delayStart=0 "Time to start tracking power profiles";
        parameter Modelica.Units.SI.Time timeScale=60*60
          "Time scale of first table column";

        parameter Modelica.Units.SI.Power W_nominal_BOP=4.13285e8 "Nominal BOP Power";

        parameter Modelica.Units.SI.Power W_IP_nom(displayUnit="MW")=51.1454e6
          "Nominal electrical power consumption in the IP";
        final parameter Modelica.Units.SI.Power W_IP_max(displayUnit="MW")=
          W_IP_nom "Maximum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power W_IP_min(displayUnit="MW")=20.9561e6
          "Minimum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power HTSE_Q=18.5;
        parameter Real HTSE_eff=0.35;

        input Modelica.Units.SI.Power Solar_Power "Wind power";

        output Modelica.Units.SI.Power W_totalSetpoint_BOP=switch_BOP.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_EG=switch_EG.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_IP=switch_IP.y
          annotation (Dialog(group="Outputs", enable=false));
        parameter String fileName=Modelica.Utilities.Files.loadResource(
            "C:/Users/raj180002/Documents/Dymola/Journal_NHES_Data/Demand/August_24_Solar.txt")
          "File where matrix is stored";

        Modelica.Blocks.Logical.LessThreshold greaterEqualThreshold1(threshold=
              delayStart)
          annotation (Placement(transformation(extent={{-112,18},{-92,38}})));
        Modelica.Blocks.Logical.Switch switch_BOP
          annotation (Placement(transformation(extent={{2,108},{22,128}})));
        Modelica.Blocks.Sources.Constant BOP_nominal(k=W_nominal_BOP)
          annotation (Placement(transformation(extent={{-44,132},{-24,152}})));

        Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
          annotation (Placement(transformation(extent={{-160,18},{-140,38}})));

        Modelica.Blocks.Logical.Switch switch_EG
          annotation (Placement(transformation(extent={{44,18},{64,38}})));
        Modelica.Blocks.Logical.Switch switch_IP
          annotation (Placement(transformation(extent={{48,-78},{68,-58}})));
        Modelica.Blocks.Sources.Constant HTSE_nominal(k=W_IP_nom)
          annotation (Placement(transformation(extent={{-36,-54},{-16,-34}})));
        Modelica.Blocks.Sources.RealExpression IPDemand(y=BOP_nominal.y + Solar_Power -
              HTSE_Q*HTSE_eff - GridDemand.y)
          annotation (Placement(transformation(extent={{-72,-120},{-52,-100}})));
        Modelica.Blocks.Sources.RealExpression BOPDemand(y=GridDemand.y +
              limiter_HTSE_W.y - Solar_Power)
          annotation (Placement(transformation(extent={{-46,94},{-26,114}})));
        Modelica.Blocks.Nonlinear.Limiter limiter_HTSE_W(uMax=W_IP_max, uMin=W_IP_min)
          annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={-12,-94})));
        Modelica.Blocks.Sources.RealExpression Grid_nominal(y=BOP_nominal.y -
              HTSE_nominal.y)
          annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
        Modelica.Blocks.Sources.CombiTimeTable demand_EG(
          tableOnFile=true,
          timeScale=timeScale,
          startTime=delayStart,
          tableName="Grid",
          fileName=fileName)
          annotation (Placement(transformation(extent={{-36,-12},{-16,8}})));
        Modelica.Blocks.Math.Gain GridDemand(k=90e06)
          annotation (Placement(transformation(extent={{4,-12},{24,8}})));
      equation
        connect(BOP_nominal.y, switch_BOP.u1) annotation (Line(points={{-23,142},{-6,142},
                {-6,126},{0,126}},         color={0,0,127}));
        connect(clock.y, greaterEqualThreshold1.u)
          annotation (Line(points={{-139,28},{-114,28}},           color={0,0,127}));
        connect(greaterEqualThreshold1.y, switch_BOP.u2) annotation (Line(points={{-91,28},
                {-72,28},{-72,118},{0,118}},     color={255,0,255}));
        connect(switch_EG.u2, switch_BOP.u2) annotation (Line(points={{42,28},{-72,28},
                {-72,118},{0,118}},                    color={255,0,255}));
        connect(switch_IP.u2, switch_BOP.u2) annotation (Line(points={{46,-68},{-72,-68},
                {-72,118},{0,118}}, color={255,0,255}));
        connect(HTSE_nominal.y, switch_IP.u1) annotation (Line(points={{-15,-44},{30,-44},
                {30,-60},{46,-60}}, color={0,0,127}));
        connect(BOPDemand.y, switch_BOP.u3) annotation (Line(points={{-25,104},{-10,104},
                {-10,110},{0,110}}, color={0,0,127}));
        connect(IPDemand.y, limiter_HTSE_W.u)
          annotation (Line(points={{-51,-110},{-42,-110},{-42,-94},{-24,-94}},
                                                         color={0,0,127}));
        connect(limiter_HTSE_W.y, switch_IP.u3) annotation (Line(points={{-1,-94},
                {30,-94},{30,-76},{46,-76}},
                                         color={0,0,127}));
        connect(Grid_nominal.y, switch_EG.u1) annotation (Line(points={{-25,60},{14,60},
                {14,36},{42,36}}, color={0,0,127}));
        connect(demand_EG.y[1], GridDemand.u)
          annotation (Line(points={{-15,-2},{2,-2}}, color={0,0,127}));
        connect(GridDemand.y, switch_EG.u3) annotation (Line(points={{25,-2},{32,-2},{
                32,20},{42,20}}, color={0,0,127}));
      annotation(defaultComponentName="SC", experiment(
            StopTime=86400,
            __Dymola_NumberOfIntervals=3600,
            __Dymola_Algorithm="Dassl"),
          Diagram(coordinateSystem(extent={{-180,-160},{160,160}})),
          Icon(coordinateSystem(extent={{-180,-160},{160,160}}), graphics={
                        Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Input Setpoints: Modelica Path")}));
      end Solar_BOP_IP_DailyDemand;
    end SupervisoryControls;

    package WindPlant
      model WindModel_Day
        "Generic wind power plant simulation with real wind data"
        extends Modelica.Icons.Example;
        parameter String fileName = Modelica.Utilities.Files.loadResource("C:/Users/raj180002/OneDrive - The University of Texas at Dallas/Dymola/Journal_NHES_Data/WindData/Wind_May3_24.txt") "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
        WindPowerPlants.Plants.GenericVariableSpeed plant(limitMot = 0.01, k = 120 * 112.8) annotation(Placement(transformation(extent = {{10, -10}, {30, 10}})));
        WindPowerPlants.WindSources.RealData windSource(fileName=fileName)
          annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
        WindPowerPlants.Blocks.SpeedAdaptor speedadaptor1(hin = 50, hout = 105, roughness = 0.1) annotation(Placement(transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}})));
        Modelica.Blocks.Interfaces.RealOutput Power
          annotation (Placement(transformation(extent={{96,8},{116,28}})));
      equation
        connect(windSource.v, speedadaptor1.vin) annotation(Line(points={{-27,0},{-22,
                0}},                                                                                        color = {0, 0, 127}));
        connect(speedadaptor1.vout, plant.v) annotation(Line(points = {{1, 0}, {4, 0}, {4, 8.88178e-16}, {8, 8.88178e-16}}, color = {0, 0, 127}));
        connect(plant.power, Power)
          annotation (Line(points={{26,11},{26,18},{106,18}}, color={0,0,127}));
        annotation(experiment(
            StopTime=86400,
            Interval=60,
            __Dymola_Algorithm="Dassl"));
      end WindModel_Day;

      model WindModel_Hour
        "Generic wind power plant simulation with real wind data"
        extends Modelica.Icons.Example;
        parameter String fileName = Modelica.Utilities.Files.loadResource("C:/Users/raj180002/OneDrive - The University of Texas at Dallas/Dymola/Library/AA My packages/WindPowerPlants/Resources/Data/beresford2006.txt") "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
        WindPowerPlants.Plants.GenericVariableSpeed plant(limitMot = 0.01, k = 120 * 112.8) annotation(Placement(transformation(extent = {{10, -10}, {30, 10}})));
        WindPowerPlants.WindSources.RealData windSource(fileName=fileName)
          annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
        WindPowerPlants.Blocks.SpeedAdaptor speedadaptor1(hin = 50, hout = 105, roughness = 0.1) annotation(Placement(transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}})));
        Modelica.Blocks.Interfaces.RealOutput Power
          annotation (Placement(transformation(extent={{96,8},{116,28}})));
      equation
        connect(windSource.v, speedadaptor1.vin) annotation(Line(points = {{-29, 0}, {-25.5, 0}, {-22, 0}}, color = {0, 0, 127}));
        connect(speedadaptor1.vout, plant.v) annotation(Line(points = {{1, 0}, {4, 0}, {4, 8.88178e-16}, {8, 8.88178e-16}}, color = {0, 0, 127}));
        connect(plant.power, Power)
          annotation (Line(points={{26,11},{26,18},{106,18}}, color={0,0,127}));
        annotation(experiment(
            StartTime=0,
            StopTime=7000,
            Interval=600,
            __Dymola_Algorithm="Dassl"));
      end WindModel_Hour;

      model WindPlant_Individual_Day
          extends
          NHES.Systems.Templates.SubSystem_Standalone.BaseClasses.Partial_SubSystem_A(
          redeclare replaceable
            NHES.Systems.Templates.SubSystem_Standalone.CS.CS_Dummy CS,
          redeclare replaceable
            NHES.Systems.Templates.SubSystem_Standalone.CS.ED_Dummy ED,
          redeclare NHES.Systems.Templates.SubSystem_Standalone.Data.Data_Dummy
            data);

       parameter Integer no_units=24;

        Modelica.Blocks.Interfaces.RealOutput WindPower
          annotation (Placement(transformation(extent={{98,-4},{118,16}}),
              iconTransformation(extent={{98,-4},{118,16}})));

       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel
          annotation (Placement(transformation(extent={{-100,78},{-80,98}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel1
          annotation (Placement(transformation(extent={{-100,48},{-80,68}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel2
          annotation (Placement(transformation(extent={{-100,22},{-80,42}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel3
          annotation (Placement(transformation(extent={{-100,-6},{-80,14}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel4
          annotation (Placement(transformation(extent={{-100,-32},{-80,-12}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel5
          annotation (Placement(transformation(extent={{-98,-54},{-78,-34}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel6
          annotation (Placement(transformation(extent={{-98,-82},{-78,-62}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel7
          annotation (Placement(transformation(extent={{-98,-110},{-78,-90}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel8
          annotation (Placement(transformation(extent={{-96,-136},{-76,-116}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel9
          annotation (Placement(transformation(extent={{-98,-160},{-78,-140}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel10
          annotation (Placement(transformation(extent={{-96,-186},{-76,-166}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel11
          annotation (Placement(transformation(extent={{-96,-212},{-76,-192}})));
        Modelica.Blocks.Math.MultiSum AggregatedWindPower(nu=12)
          annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel12
          annotation (Placement(transformation(extent={{-2,70},{18,90}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel13
          annotation (Placement(transformation(extent={{-2,46},{18,66}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel14
          annotation (Placement(transformation(extent={{-4,22},{16,42}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel15
          annotation (Placement(transformation(extent={{-2,-4},{18,16}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel16
          annotation (Placement(transformation(extent={{-2,-28},{18,-8}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel17
          annotation (Placement(transformation(extent={{0,-52},{20,-32}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel18
          annotation (Placement(transformation(extent={{0,-76},{20,-56}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel19
          annotation (Placement(transformation(extent={{0,-106},{20,-86}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel20
          annotation (Placement(transformation(extent={{0,-132},{20,-112}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel21
          annotation (Placement(transformation(extent={{2,-158},{22,-138}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel22
          annotation (Placement(transformation(extent={{2,-186},{22,-166}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel23
          annotation (Placement(transformation(extent={{4,-212},{24,-192}})));
        Modelica.Blocks.Math.MultiSum AggregatedWindPower1(nu=12)
          annotation (Placement(transformation(extent={{42,46},{62,66}})));
        Modelica.Blocks.Math.MultiSum AggregatedWindPower2(nu=2)
          annotation (Placement(transformation(extent={{88,-244},{108,-224}})));
        Modelica.Blocks.Math.Gain gain(k=-1)
          annotation (Placement(transformation(extent={{128,-244},{148,-224}})));
      equation
        connect(windmodel.Power, AggregatedWindPower.u[1]) annotation (Line(
              points={{-79.4,89.8},{-59.7,89.8},{-59.7,66.4167},{-40,66.4167}},
              color={0,0,127}));
        connect(windmodel1.Power, AggregatedWindPower.u[2]) annotation (Line(
              points={{-79.4,59.8},{-58.7,59.8},{-58.7,65.25},{-40,65.25}},
              color={0,0,127}));
        connect(windmodel2.Power, AggregatedWindPower.u[3]) annotation (Line(
              points={{-79.4,33.8},{-59.7,33.8},{-59.7,64.0833},{-40,64.0833}},
              color={0,0,127}));
        connect(windmodel3.Power, AggregatedWindPower.u[4]) annotation (Line(
              points={{-79.4,5.8},{-79.4,33.9},{-40,33.9},{-40,62.9167}}, color=
               {0,0,127}));
        connect(windmodel4.Power, AggregatedWindPower.u[5]) annotation (Line(
              points={{-79.4,-20.2},{-79.4,22.9},{-40,22.9},{-40,61.75}}, color=
               {0,0,127}));
        connect(windmodel5.Power, AggregatedWindPower.u[6]) annotation (Line(
              points={{-77.4,-42.2},{-77.4,8.9},{-40,8.9},{-40,60.5833}}, color=
               {0,0,127}));
        connect(windmodel6.Power, AggregatedWindPower.u[7]) annotation (Line(
              points={{-77.4,-70.2},{-77.4,-7.1},{-40,-7.1},{-40,59.4167}},
              color={0,0,127}));
        connect(windmodel7.Power, AggregatedWindPower.u[8]) annotation (Line(
              points={{-77.4,-98.2},{-77.4,-20.1},{-40,-20.1},{-40,58.25}},
              color={0,0,127}));
        connect(windmodel8.Power, AggregatedWindPower.u[9]) annotation (Line(
              points={{-75.4,-124.2},{-75.4,-31.1},{-40,-31.1},{-40,57.0833}},
              color={0,0,127}));
        connect(windmodel9.Power, AggregatedWindPower.u[10]) annotation (Line(
              points={{-77.4,-148.2},{-77.4,-45.1},{-40,-45.1},{-40,55.9167}},
              color={0,0,127}));
        connect(windmodel10.Power, AggregatedWindPower.u[11]) annotation (Line(
              points={{-75.4,-174.2},{-75.4,-55.1},{-40,-55.1},{-40,54.75}},
              color={0,0,127}));
        connect(windmodel11.Power, AggregatedWindPower.u[12]) annotation (Line(
              points={{-75.4,-200.2},{-75.4,-69.1},{-40,-69.1},{-40,53.5833}},
              color={0,0,127}));
        connect(windmodel12.Power, AggregatedWindPower1.u[1]) annotation (Line(
              points={{18.6,81.8},{18.6,70.9},{42,70.9},{42,62.4167}}, color={0,
                0,127}));
        connect(windmodel13.Power, AggregatedWindPower1.u[2]) annotation (Line(
              points={{18.6,57.8},{30.3,57.8},{30.3,61.25},{42,61.25}}, color={
                0,0,127}));
        connect(windmodel14.Power, AggregatedWindPower1.u[3]) annotation (Line(
              points={{16.6,33.8},{29.3,33.8},{29.3,60.0833},{42,60.0833}},
              color={0,0,127}));
        connect(windmodel15.Power, AggregatedWindPower1.u[4]) annotation (Line(
              points={{18.6,7.8},{18.6,33.9},{42,33.9},{42,58.9167}}, color={0,
                0,127}));
        connect(windmodel16.Power, AggregatedWindPower1.u[5]) annotation (Line(
              points={{18.6,-16.2},{18.6,19.9},{42,19.9},{42,57.75}}, color={0,
                0,127}));
        connect(windmodel17.Power, AggregatedWindPower1.u[6]) annotation (Line(
              points={{20.6,-40.2},{20.6,7.9},{42,7.9},{42,56.5833}}, color={0,
                0,127}));
        connect(windmodel18.Power, AggregatedWindPower1.u[7]) annotation (Line(
              points={{20.6,-64.2},{20.6,-3.1},{42,-3.1},{42,55.4167}}, color={
                0,0,127}));
        connect(windmodel19.Power, AggregatedWindPower1.u[8]) annotation (Line(
              points={{20.6,-94.2},{20.6,-19.1},{42,-19.1},{42,54.25}}, color={
                0,0,127}));
        connect(windmodel20.Power, AggregatedWindPower1.u[9]) annotation (Line(
              points={{20.6,-120.2},{20.6,-32.1},{42,-32.1},{42,53.0833}},
              color={0,0,127}));
        connect(windmodel21.Power, AggregatedWindPower1.u[10]) annotation (Line(
              points={{22.6,-146.2},{22.6,-43.1},{42,-43.1},{42,51.9167}},
              color={0,0,127}));
        connect(windmodel22.Power, AggregatedWindPower1.u[11]) annotation (Line(
              points={{22.6,-174.2},{22.6,-57.1},{42,-57.1},{42,50.75}}, color=
                {0,0,127}));
        connect(windmodel23.Power, AggregatedWindPower1.u[12]) annotation (Line(
              points={{24.6,-200.2},{24.6,-73.1},{42,-73.1},{42,49.5833}},
              color={0,0,127}));
        connect(AggregatedWindPower.y, AggregatedWindPower2.u[1]) annotation (
            Line(points={{-18.3,60},{-14,60},{-14,-248},{80,-248},{80,-236},{84,
                -236},{84,-230.5},{88,-230.5}}, color={0,0,127}));
        connect(AggregatedWindPower1.y, AggregatedWindPower2.u[2]) annotation (
            Line(points={{63.7,56},{76,56},{76,-237.5},{88,-237.5}}, color={0,0,
                127}));
        connect(AggregatedWindPower2.y, gain.u)
          annotation (Line(points={{109.7,-234},{126,-234}}, color={0,0,127}));
        connect(gain.y, WindPower) annotation (Line(points={{149,-234},{168,
                -234},{168,6},{108,6}}, color={0,0,127}));
       annotation(experiment(
            StopTime=86400,
            Interval=600,
            __Dymola_Algorithm="Dassl"),
          Diagram(coordinateSystem(extent={{-120,-260},{180,140}})),
          Icon(coordinateSystem(extent={{-120,-260},{180,140}}), graphics={Text(
                extent={{-36,-4},{36,-50}},
                lineColor={0,0,0},
                textString="WindPlant
")}));
      end WindPlant_Individual_Day;

      model WindPlant_MultiInstantiate_Day
          extends
          NHES.Systems.Templates.SubSystem_Standalone.BaseClasses.Partial_SubSystem_A(
          redeclare replaceable
            NHES.Systems.Templates.SubSystem_Standalone.CS.CS_Dummy CS,
          redeclare replaceable
            NHES.Systems.Templates.SubSystem_Standalone.CS.ED_Dummy ED,
          redeclare NHES.Systems.Templates.SubSystem_Standalone.Data.Data_Dummy
            data);

       parameter Integer no_units=17;

        Modelica.Blocks.Math.MultiSum AggregatedWindPower(k=fill(-1, no_units), nu=
              no_units)
          annotation (Placement(transformation(extent={{-8,22},{14,44}})));

        Journal_IES_Simulations.Components.WindPlant.WindModel_Day wind_unit[no_units]
          annotation (Placement(transformation(extent={{-78,18},{-56,40}})));

        Modelica.Blocks.Interfaces.RealOutput WindPower
          annotation (Placement(transformation(extent={{100,24},{120,44}})));
      equation
        for i in 1:no_units loop
          connect(wind_unit[i].plant.power, AggregatedWindPower.u[i]);
        end for;

        connect(AggregatedWindPower.y, WindPower) annotation (Line(points={{15.87,33},
                {57.935,33},{57.935,34},{110,34}}, color={0,0,127}));
       annotation(experiment(
            StopTime=86400,
            Interval=60,
            __Dymola_Algorithm="Dassl"),
          Diagram(coordinateSystem(extent={{-80,-40},{100,160}})),
          Icon(coordinateSystem(extent={{-80,-40},{100,160}})));
      end WindPlant_MultiInstantiate_Day;

      model WindPlant_MultiInstantiate_Hours
          extends
          NHES.Systems.Templates.SubSystem_Standalone.BaseClasses.Partial_SubSystem_A(
          redeclare replaceable
            NHES.Systems.Templates.SubSystem_Standalone.CS.CS_Dummy CS,
          redeclare replaceable
            NHES.Systems.Templates.SubSystem_Standalone.CS.ED_Dummy ED,
          redeclare NHES.Systems.Templates.SubSystem_Standalone.Data.Data_Dummy
            data);

       parameter Integer no_units=24;

        Modelica.Blocks.Math.MultiSum AggregatedWindPower(k=fill(-1, no_units), nu=
              no_units)
          annotation (Placement(transformation(extent={{-8,22},{14,44}})));

        Journal_IES_Simulations.Components.WindPlant.WindModel_Hour wind_unit[no_units]
          annotation (Placement(transformation(extent={{-78,18},{-56,40}})));

        Modelica.Blocks.Interfaces.RealOutput WindPower
          annotation (Placement(transformation(extent={{100,24},{120,44}})));
      equation
        for i in 1:no_units loop
          connect(wind_unit[i].plant.power, AggregatedWindPower.u[i]);
        end for;

        connect(AggregatedWindPower.y, WindPower) annotation (Line(points={{15.87,33},
                {57.935,33},{57.935,34},{110,34}}, color={0,0,127}));
        connect(WindPower, WindPower)
          annotation (Line(points={{110,34},{110,34}}, color={0,0,127}));
       annotation(experiment(
            StopTime=5000,
            Interval=60,
            __Dymola_Algorithm="Dassl"),
          Diagram(coordinateSystem(extent={{-80,-40},{100,160}})),
          Icon(coordinateSystem(extent={{-80,-40},{100,160}}), graphics={Text(
                extent={{-38,14},{46,-28}},
                lineColor={0,0,0},
                textStyle={TextStyle.Bold},
                fontSize=12,
                textString="Wind Plant
")}));
      end WindPlant_MultiInstantiate_Hours;

      model WindPlant_Individual_Hours
          extends
          NHES.Systems.Templates.SubSystem_Standalone.BaseClasses.Partial_SubSystem_A(
          redeclare replaceable
            NHES.Systems.Templates.SubSystem_Standalone.CS.CS_Dummy CS,
          redeclare replaceable
            NHES.Systems.Templates.SubSystem_Standalone.CS.ED_Dummy ED,
          redeclare NHES.Systems.Templates.SubSystem_Standalone.Data.Data_Dummy
            data);

       parameter Integer no_units=24;

        Modelica.Blocks.Interfaces.RealOutput WindPower
          annotation (Placement(transformation(extent={{98,-4},{118,16}}),
              iconTransformation(extent={{98,-4},{118,16}})));

       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{-100,78},{-80,98}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel1(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{-100,48},{-80,68}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel2(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{-100,22},{-80,42}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel3(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{-100,-6},{-80,14}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel4(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{-100,-32},{-80,-12}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel5(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{-98,-54},{-78,-34}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel6(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{-98,-82},{-78,-62}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel7(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{-98,-110},{-78,-90}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel8(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{-96,-136},{-76,-116}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel9(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{-98,-160},{-78,-140}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel10(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{-96,-186},{-76,-166}})));
       Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel11(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{-96,-212},{-76,-192}})));
        Modelica.Blocks.Math.MultiSum AggregatedWindPower(nu=12)
          annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel12(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{-2,70},{18,90}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel13(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{-2,46},{18,66}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel14(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{-4,22},{16,42}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel15(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{-2,-4},{18,16}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel16(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{-2,-28},{18,-8}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel17(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{0,-52},{20,-32}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel18(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{0,-76},{20,-56}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel19(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{0,-106},{20,-86}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel20(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{0,-132},{20,-112}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel21(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{2,-158},{22,-138}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel22(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{2,-186},{22,-166}})));
        Journal_IES_Simulations.Components.WindPlant.WindModel_Day windmodel23(
            windSource(combiTimeTable(nextTimeEvent(start=600.0),
                nextTimeEventScaled(start=600.0))))
          annotation (Placement(transformation(extent={{4,-212},{24,-192}})));
        Modelica.Blocks.Math.MultiSum AggregatedWindPower1(nu=12)
          annotation (Placement(transformation(extent={{42,46},{62,66}})));
        Modelica.Blocks.Math.MultiSum AggregatedWindPower2(nu=2)
          annotation (Placement(transformation(extent={{88,-244},{108,-224}})));
        Modelica.Blocks.Math.Gain gain(k=-1)
          annotation (Placement(transformation(extent={{128,-244},{148,-224}})));
      equation
        connect(windmodel.Power, AggregatedWindPower.u[1]) annotation (Line(
              points={{-79.4,89.8},{-59.7,89.8},{-59.7,66.4167},{-40,66.4167}},
              color={0,0,127}));
        connect(windmodel1.Power, AggregatedWindPower.u[2]) annotation (Line(
              points={{-79.4,59.8},{-58.7,59.8},{-58.7,65.25},{-40,65.25}},
              color={0,0,127}));
        connect(windmodel2.Power, AggregatedWindPower.u[3]) annotation (Line(
              points={{-79.4,33.8},{-59.7,33.8},{-59.7,64.0833},{-40,64.0833}},
              color={0,0,127}));
        connect(windmodel3.Power, AggregatedWindPower.u[4]) annotation (Line(
              points={{-79.4,5.8},{-79.4,33.9},{-40,33.9},{-40,62.9167}}, color=
               {0,0,127}));
        connect(windmodel4.Power, AggregatedWindPower.u[5]) annotation (Line(
              points={{-79.4,-20.2},{-79.4,22.9},{-40,22.9},{-40,61.75}}, color=
               {0,0,127}));
        connect(windmodel5.Power, AggregatedWindPower.u[6]) annotation (Line(
              points={{-77.4,-42.2},{-77.4,8.9},{-40,8.9},{-40,60.5833}}, color=
               {0,0,127}));
        connect(windmodel6.Power, AggregatedWindPower.u[7]) annotation (Line(
              points={{-77.4,-70.2},{-77.4,-7.1},{-40,-7.1},{-40,59.4167}},
              color={0,0,127}));
        connect(windmodel7.Power, AggregatedWindPower.u[8]) annotation (Line(
              points={{-77.4,-98.2},{-77.4,-20.1},{-40,-20.1},{-40,58.25}},
              color={0,0,127}));
        connect(windmodel8.Power, AggregatedWindPower.u[9]) annotation (Line(
              points={{-75.4,-124.2},{-75.4,-31.1},{-40,-31.1},{-40,57.0833}},
              color={0,0,127}));
        connect(windmodel9.Power, AggregatedWindPower.u[10]) annotation (Line(
              points={{-77.4,-148.2},{-77.4,-45.1},{-40,-45.1},{-40,55.9167}},
              color={0,0,127}));
        connect(windmodel10.Power, AggregatedWindPower.u[11]) annotation (Line(
              points={{-75.4,-174.2},{-75.4,-55.1},{-40,-55.1},{-40,54.75}},
              color={0,0,127}));
        connect(windmodel11.Power, AggregatedWindPower.u[12]) annotation (Line(
              points={{-75.4,-200.2},{-75.4,-69.1},{-40,-69.1},{-40,53.5833}},
              color={0,0,127}));
        connect(windmodel12.Power, AggregatedWindPower1.u[1]) annotation (Line(
              points={{18.6,81.8},{18.6,70.9},{42,70.9},{42,62.4167}}, color={0,
                0,127}));
        connect(windmodel13.Power, AggregatedWindPower1.u[2]) annotation (Line(
              points={{18.6,57.8},{30.3,57.8},{30.3,61.25},{42,61.25}}, color={
                0,0,127}));
        connect(windmodel14.Power, AggregatedWindPower1.u[3]) annotation (Line(
              points={{16.6,33.8},{29.3,33.8},{29.3,60.0833},{42,60.0833}},
              color={0,0,127}));
        connect(windmodel15.Power, AggregatedWindPower1.u[4]) annotation (Line(
              points={{18.6,7.8},{18.6,33.9},{42,33.9},{42,58.9167}}, color={0,
                0,127}));
        connect(windmodel16.Power, AggregatedWindPower1.u[5]) annotation (Line(
              points={{18.6,-16.2},{18.6,19.9},{42,19.9},{42,57.75}}, color={0,
                0,127}));
        connect(windmodel17.Power, AggregatedWindPower1.u[6]) annotation (Line(
              points={{20.6,-40.2},{20.6,7.9},{42,7.9},{42,56.5833}}, color={0,
                0,127}));
        connect(windmodel18.Power, AggregatedWindPower1.u[7]) annotation (Line(
              points={{20.6,-64.2},{20.6,-3.1},{42,-3.1},{42,55.4167}}, color={
                0,0,127}));
        connect(windmodel19.Power, AggregatedWindPower1.u[8]) annotation (Line(
              points={{20.6,-94.2},{20.6,-19.1},{42,-19.1},{42,54.25}}, color={
                0,0,127}));
        connect(windmodel20.Power, AggregatedWindPower1.u[9]) annotation (Line(
              points={{20.6,-120.2},{20.6,-32.1},{42,-32.1},{42,53.0833}},
              color={0,0,127}));
        connect(windmodel21.Power, AggregatedWindPower1.u[10]) annotation (Line(
              points={{22.6,-146.2},{22.6,-43.1},{42,-43.1},{42,51.9167}},
              color={0,0,127}));
        connect(windmodel22.Power, AggregatedWindPower1.u[11]) annotation (Line(
              points={{22.6,-174.2},{22.6,-57.1},{42,-57.1},{42,50.75}}, color=
                {0,0,127}));
        connect(windmodel23.Power, AggregatedWindPower1.u[12]) annotation (Line(
              points={{24.6,-200.2},{24.6,-73.1},{42,-73.1},{42,49.5833}},
              color={0,0,127}));
        connect(AggregatedWindPower.y, AggregatedWindPower2.u[1]) annotation (
            Line(points={{-18.3,60},{-14,60},{-14,-248},{80,-248},{80,-236},{84,
                -236},{84,-230.5},{88,-230.5}}, color={0,0,127}));
        connect(AggregatedWindPower1.y, AggregatedWindPower2.u[2]) annotation (
            Line(points={{63.7,56},{76,56},{76,-237.5},{88,-237.5}}, color={0,0,
                127}));
        connect(AggregatedWindPower2.y, gain.u)
          annotation (Line(points={{109.7,-234},{126,-234}}, color={0,0,127}));
        connect(gain.y, WindPower) annotation (Line(points={{149,-234},{168,
                -234},{168,6},{108,6}}, color={0,0,127}));
       annotation(experiment(
            StopTime=5000,
            Interval=60,
            __Dymola_Algorithm="Dassl"),
          Diagram(coordinateSystem(extent={{-120,-260},{180,140}})),
          Icon(coordinateSystem(extent={{-120,-260},{180,140}}), graphics={Text(
                extent={{-36,-4},{36,-50}},
                lineColor={0,0,0},
                textString="WindPlant
")}));
      end WindPlant_Individual_Hours;

      model Wind_connector_Transform

        Modelica.Units.SI.Power W "Actual power generation";
        Modelica.Units.SI.Frequency f "Frequency";
        Modelica.Blocks.Interfaces.RealInput powerGeneration annotation (Placement(
              transformation(
              origin={-105,20},
              extent={{13,12},{-13,-12}},
              rotation=180), iconTransformation(
              extent={{13,12},{-13,-12}},
              rotation=180,
              origin={-100,22})));
        TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_Flow portElec_a annotation (Placement(
              transformation(extent={{90,10},{110,30}}), iconTransformation(extent={{90,10},
                  {110,30}})));
      equation
          W =powerGeneration
            "Power generation determined by connector";

        portElec_a.f = f;
        portElec_a.W = -W;
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Line(
                points={{2,20},{80,20}},
                color={238,46,47},
                thickness=1),
              Text(
                extent={{-34,58},{32,38}},
                lineColor={238,46,47},
                lineThickness=1,
                textString="QuasiStaticPoly 2 Transform"),
              Line(
                points={{-74,20},{-4,20}},
                color={28,108,200},
                thickness=1),
              Ellipse(
                extent={{0,22},{-4,16}},
                lineColor={28,108,200},
                lineThickness=1)}),                                    Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Wind_connector_Transform;
    end WindPlant;

    package SolarPlant
      model PVmodel_Singlephase_Day
        extends Modelica.Icons.Example;
        parameter Integer nsModule = 50 "Number of series connected modules";
        parameter Integer npModule = 20 "Number of parallel connected modules";
        parameter String csvFileName = "TGM_Trina_Analytical_20160629_power.csv";
        PhotoVoltaics.Components.SimplePhotoVoltaics.SimplePlantSymmetric plant(
          moduleData=moduleData,
          npModule=npModule,
          nsModule=nsModule,
          useConstantIrradiance=false) annotation (Placement(visible=true, transformation(
              origin={-44,18},
              extent={{10,-10},{-10,10}},
              rotation=90)));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (
          Placement(visible = true, transformation(origin={-44,-12},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PhotoVoltaics.Components.Converters.QuasiStaticSinglePhaseConverter converter annotation (
          Placement(transformation(extent={{16,8},{36,28}})));
        PhotoVoltaics.Components.Blocks.MPTrackerSample mpTracker(VmpRef = nsModule * moduleData.VmpRef, ImpRef = npModule * moduleData.ImpRef, samplePeriod = 10) annotation (
          Placement(transformation(extent={{-4,-42},{16,-22}})));
        Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundAC
          annotation (Placement(transformation(extent={{66,-22},{86,-2}})));
        Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource
          voltageSource(
          f=50,
          V=230,
          phi=0,
          gamma(start=0, fixed=true)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={76,18})));
        Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor annotation (
          Placement(transformation(extent={{-24,28},{-4,48}})));
        parameter PhotoVoltaics.Records.TSM_230_PC05 moduleData annotation (
          Placement(visible = true, transformation(origin={70,78},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PhotoVoltaics.Sources.Irradiance.Irradiance irradiance(
          startDay=1,
          startMonth=08,
          startYear=2016,
          latitude(displayUnit="deg"))
          annotation (Placement(transformation(extent={{-90,8},{-70,28}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=3*powerSensor.power)
          annotation (Placement(transformation(extent={{44,-50},{64,-30}})));
        Modelica.Blocks.Interfaces.RealOutput Power
          annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
      equation
        connect(ground.p, plant.n) annotation (
          Line(points={{-44,-2},{-44,8}},         color = {0, 0, 255}));
        connect(mpTracker.vRef, converter.vDCRef) annotation (
          Line(points={{17,-32},{20,-32},{20,6}},          color = {0, 0, 127}));
        connect(converter.ac_n, groundAC.pin) annotation (
          Line(points={{36,12},{36,-2},{76,-2}},           color = {85, 170, 255}));
        connect(groundAC.pin, voltageSource.pin_n) annotation (
          Line(points={{76,-2},{76,8}},                    color = {85, 170, 255}));
        connect(powerSensor.nc, converter.dc_p) annotation (
          Line(points={{-4,38},{16,38},{16,24}},                   color = {0, 0, 255}));
        connect(mpTracker.power, powerSensor.power) annotation (
          Line(points={{-6,-32},{-24,-32},{-24,27}},                     color = {0, 0, 127}));
        connect(powerSensor.pc, powerSensor.pv) annotation (
          Line(points={{-24,38},{-24,48},{-14,48}},        color = {0, 0, 255}));
        connect(converter.ac_p, voltageSource.pin_p) annotation (
          Line(points={{36,24},{36,38},{76,38},{76,28}},                 color = {85, 170, 255}));
        connect(plant.p, powerSensor.pc) annotation (
          Line(points={{-44,28},{-44,38},{-24,38}},       color = {0, 0, 255}));
        connect(powerSensor.nv, ground.p) annotation (
          Line(points={{-14,28},{-14,-2},{-44,-2}},                               color = {0, 0, 255}));
        connect(ground.p, converter.dc_n) annotation (
          Line(points={{-44,-2},{16,-2},{16,12}},           color = {0, 0, 255}));
        connect(irradiance.irradiance, plant.variableIrradiance)
          annotation (Line(points={{-69,18},{-56,18}}, color={0,0,127}));
        connect(realExpression.y, Power)
          annotation (Line(points={{65,-40},{110,-40}}, color={0,0,127}));
        annotation (
          experiment(StopTime = 86400, Interval = 60, Tolerance = 1e-08, __Dymola_Algorithm = "Rkfix4"));
      end PVmodel_Singlephase_Day;

      model SolarPlant_MultiInstantiate_Day
          extends
          NHES.Systems.Templates.SubSystem_Standalone.BaseClasses.Partial_SubSystem_A(
          redeclare replaceable
            NHES.Systems.Templates.SubSystem_Standalone.CS.CS_Dummy CS,
          redeclare replaceable
            NHES.Systems.Templates.SubSystem_Standalone.CS.ED_Dummy ED,
          redeclare NHES.Systems.Templates.SubSystem_Standalone.Data.Data_Dummy
            data);

       parameter Integer no_units=5;

        Modelica.Blocks.Math.MultiSum AggregatedSolarPower(k=fill(1, no_units),nu=no_units)
          annotation (Placement(transformation(extent={{-8,22},{14,44}})));

        Journal_IES_Simulations.Components.SolarPlant.PVmodel_Singlephase_Day pv_unit[
          no_units] annotation (Placement(transformation(extent={{-90,20},{-68,42}})));

        Modelica.Blocks.Interfaces.RealOutput SolarPower
          annotation (Placement(transformation(extent={{100,24},{120,44}})));
        Modelica.Blocks.Math.Gain gain(k=10)
          annotation (Placement(transformation(extent={{46,24},{66,44}})));
      equation
        for i in 1:no_units loop
            connect(pv_unit[i].Power, AggregatedSolarPower.u[i]);
        end for;

        connect(AggregatedSolarPower.y, gain.u) annotation (Line(points={{15.87,33},{28.935,
                33},{28.935,34},{44,34}}, color={0,0,127}));
        connect(gain.y, SolarPower)
          annotation (Line(points={{67,34},{110,34}}, color={0,0,127}));
      annotation (
          experiment(StopTime = 86400, Interval = 60, Tolerance = 1e-08, __Dymola_Algorithm = "Rkfix4"),
          Diagram(coordinateSystem(extent={{-100,-40},{100,140}})),
          Icon(coordinateSystem(extent={{-100,-40},{100,140}})));
      end SolarPlant_MultiInstantiate_Day;

      model SolarPlant_MultiInstantiate_hours
          extends
          NHES.Systems.Templates.SubSystem_Standalone.BaseClasses.Partial_SubSystem_A(
          redeclare replaceable
            NHES.Systems.Templates.SubSystem_Standalone.CS.CS_Dummy CS,
          redeclare replaceable
            NHES.Systems.Templates.SubSystem_Standalone.CS.ED_Dummy ED,
          redeclare NHES.Systems.Templates.SubSystem_Standalone.Data.Data_Dummy
            data);

       parameter Integer no_units=12;

        Modelica.Blocks.Math.MultiSum AggregatedSolarPower(k=fill(1, no_units),nu=no_units)
          annotation (Placement(transformation(extent={{-8,22},{14,44}})));

        Journal_IES_Simulations.Components.SolarPlant.PVmodel_Singlephase_hours pv_unit[
          no_units] annotation (Placement(transformation(extent={{-90,20},{-68,42}})));

        Modelica.Blocks.Interfaces.RealOutput SolarPower
          annotation (Placement(transformation(extent={{100,24},{120,44}})));
        Modelica.Blocks.Math.Gain gain(k=10)
          annotation (Placement(transformation(extent={{46,24},{66,44}})));
      equation
        for i in 1:no_units loop
            connect(pv_unit[i].Power, AggregatedSolarPower.u[i]);
        end for;

        connect(AggregatedSolarPower.y, gain.u) annotation (Line(points={{15.87,33},{28.935,
                33},{28.935,34},{44,34}}, color={0,0,127}));
        connect(gain.y, SolarPower)
          annotation (Line(points={{67,34},{110,34}}, color={0,0,127}));
      annotation (
          experiment(
            StartTime=0,
            StopTime=5000,
            Interval=60,
            Tolerance=1e-04,
            __Dymola_Algorithm="Esdirk23a"),
          Diagram(coordinateSystem(extent={{-100,-40},{100,140}})),
          Icon(coordinateSystem(extent={{-100,-40},{100,140}}), graphics={Text(
                extent={{-38,30},{12,4}},
                lineColor={0,0,0},
                textString="Solar plant
")}));
      end SolarPlant_MultiInstantiate_hours;

      model PVmodel_Singlephase_hours
        extends Modelica.Icons.Example;
        parameter Integer nsModule = 50 "Number of series connected modules";
        parameter Integer npModule = 20 "Number of parallel connected modules";
        parameter String csvFileName = "TGM_Trina_Analytical_20160629_power.csv";
        PhotoVoltaics.Components.SimplePhotoVoltaics.SimplePlantSymmetric plant(
          moduleData=moduleData,
          npModule=npModule,
          nsModule=nsModule,
          useConstantIrradiance=false) annotation (Placement(visible=true, transformation(
              origin={-44,18},
              extent={{10,-10},{-10,10}},
              rotation=90)));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (
          Placement(visible = true, transformation(origin={-44,-12},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PhotoVoltaics.Components.Converters.QuasiStaticSinglePhaseConverter converter annotation (
          Placement(transformation(extent={{16,8},{36,28}})));
        PhotoVoltaics.Components.Blocks.MPTrackerSample mpTracker(VmpRef = nsModule * moduleData.VmpRef, ImpRef = npModule * moduleData.ImpRef, samplePeriod = 10) annotation (
          Placement(transformation(extent={{-4,-42},{16,-22}})));
        Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundAC
          annotation (Placement(transformation(extent={{66,-22},{86,-2}})));
        Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource
          voltageSource(
          f=50,
          V=230,
          phi=0,
          gamma(start=0, fixed=true)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={76,18})));
        Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor annotation (
          Placement(transformation(extent={{-24,28},{-4,48}})));
        parameter PhotoVoltaics.Records.TSM_230_PC05 moduleData annotation (
          Placement(visible = true, transformation(origin={70,78},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Sources.RealExpression realExpression(y=3*powerSensor.power)
          annotation (Placement(transformation(extent={{44,-50},{64,-30}})));
        Modelica.Blocks.Interfaces.RealOutput Power
          annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
        Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=[0,1.791; 3600,181.785;
              7200,447.07; 10800,847.23])                                                                                                                                                                                                         annotation (
          Placement(transformation(extent={{-86,8},{-66,28}})));
      equation
        connect(ground.p, plant.n) annotation (
          Line(points={{-44,-2},{-44,8}},         color = {0, 0, 255}));
        connect(mpTracker.vRef, converter.vDCRef) annotation (
          Line(points={{17,-32},{20,-32},{20,6}},          color = {0, 0, 127}));
        connect(converter.ac_n, groundAC.pin) annotation (
          Line(points={{36,12},{36,-2},{76,-2}},           color = {85, 170, 255}));
        connect(groundAC.pin, voltageSource.pin_n) annotation (
          Line(points={{76,-2},{76,8}},                    color = {85, 170, 255}));
        connect(powerSensor.nc, converter.dc_p) annotation (
          Line(points={{-4,38},{16,38},{16,24}},                   color = {0, 0, 255}));
        connect(mpTracker.power, powerSensor.power) annotation (
          Line(points={{-6,-32},{-24,-32},{-24,27}},                     color = {0, 0, 127}));
        connect(powerSensor.pc, powerSensor.pv) annotation (
          Line(points={{-24,38},{-24,48},{-14,48}},        color = {0, 0, 255}));
        connect(converter.ac_p, voltageSource.pin_p) annotation (
          Line(points={{36,24},{36,38},{76,38},{76,28}},                 color = {85, 170, 255}));
        connect(plant.p, powerSensor.pc) annotation (
          Line(points={{-44,28},{-44,38},{-24,38}},       color = {0, 0, 255}));
        connect(powerSensor.nv, ground.p) annotation (
          Line(points={{-14,28},{-14,-2},{-44,-2}},                               color = {0, 0, 255}));
        connect(ground.p, converter.dc_n) annotation (
          Line(points={{-44,-2},{16,-2},{16,12}},           color = {0, 0, 255}));
        connect(realExpression.y, Power)
          annotation (Line(points={{65,-40},{110,-40}}, color={0,0,127}));
          connect(combiTimeTable.y[1], plant.variableIrradiance)
        annotation (
          experiment(StopTime = 5000, Interval = 60, Tolerance = 1e-04, __Dymola_Algorithm = "Esdirk23a"));
        annotation (experiment(
            StartTime=3600,
            StopTime=7200,
            Interval=60,
            Tolerance=1e-08,
            __Dymola_Algorithm="Rkfix4"));
      end PVmodel_Singlephase_hours;
    end SolarPlant;
  end Components;

  package ElectricityProductn
    package Max_Production
      model Test_Nuclear_BOP_max

       parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
       parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
       parameter Integer no_modules=3;

        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-96,36},{-58,74}})));
        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-96,-12},{-58,26}})));
        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-94,-66},{-54,-26}})));
        TRANSFORM.Fluid.Volumes.MixingVolume volume(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          use_T_start=false,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
              (V=0.001),
          nPorts_b=1,
          p_start=PHS.port_b_nominal.p,
          h_start=PHS.port_b_nominal.h,
          nPorts_a=3,
          showName=false)
          annotation (Placement(transformation(extent={{-44,80},{-24,100}})));
        TRANSFORM.Fluid.Volumes.MixingVolume volume1(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          use_T_start=false,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
              (V=0.001),
          nPorts_a=1,
          p_start=PHS.port_a_nominal.p,
          h_start=PHS.port_a_nominal.h,
          nPorts_b=3,
          showName=false)
          annotation (Placement(transformation(extent={{-14,-94},{-34,-74}})));
        NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
          port_a_nominal(
            p=EM.port_b2_nominal.p,
            h=EM.port_b2_nominal.h,
            m_flow=-EM.port_b2_nominal.m_flow),
          port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
          redeclare
            NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
            CS(
            p_nominal=BOP.port_a_nominal.p,
            W_totalSetpoint=SC.W_totalSetpoint_BOP,
            delayStartTCV=0))
          annotation (Placement(transformation(extent={{42,-4},{78,32}})));
         NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=1)                                     annotation (Placement(transformation(extent={{98,-4},
                  {136,32}})));
         NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{152,-2},
                  {190,32}})));
         NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_boundaries
          EM(port_a1_nominal(
            p=PHS.port_b_nominal.p,
            h=PHS.port_b_nominal.h,
            m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
            port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h))
          annotation (Placement(transformation(extent={{-10,-6},{26,32}})));

        Components.SupervisoryControls.BOP_StepDemand SC(
          delayStart=0,
          W_nominal_BOP=1.710e08,
          GridDemand=Demand.y)
          annotation (Placement(transformation(extent={{116,54},{170,96}})));
        Modelica.Blocks.Sources.Constant Demand(k=1.710e08)
          annotation (Placement(transformation(extent={{68,54},{88,74}})));
      equation
        connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-58,
                62.6},{-50,62.6},{-50,89.3333},{-40,89.3333}},
                                                    color={0,127,255}));
        connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-58,14.6},{-46,
                14.6},{-46,90},{-40,90}}, color={0,127,255}));
        connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-54,-38},
                {-42,-38},{-42,90.6667},{-40,90.6667}},
                                                     color={0,127,255}));
        connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-28,90},{-20,90},
                {-20,20.6},{-10,20.6}}, color={0,127,255}));
        connect(EM.port_b1, volume1.port_a[1]) annotation (Line(points={{-10,5.4},{-16,
                5.4},{-16,-84},{-18,-84}}, color={0,127,255}));
        connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-58,
                47.4},{-48,47.4},{-48,-84.6667},{-30,-84.6667}},
                                                      color={0,127,255}));
        connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-58,-0.6},{-46,
                -0.6},{-46,-84},{-30,-84}},color={0,127,255}));
        connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-54,-54},
                {-44,-54},{-44,-83.3333},{-30,-83.3333}},  color={0,127,255}));
        connect(EM.port_b2, BOP.port_a) annotation (Line(points={{26,20.6},{34,20.6},{
                34,21.2},{42,21.2}}, color={0,127,255}));
        connect(EM.port_a2, BOP.port_b) annotation (Line(points={{26,5.4},{34,5.4},{34,
                6.8},{42,6.8}}, color={0,127,255}));
        connect(BOP.portElec_b, SY.port_a[1])
          annotation (Line(points={{78,14},{98,14}}, color={255,0,0}));
        connect(SY.port_Grid, EG.portElec_a) annotation (Line(points={{136,14},{146,14},
                {146,15},{152,15}}, color={255,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {200,100}})),                                        Diagram(
              coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})),
          experiment(
            StopTime=5000,
            Interval=5,
            __Dymola_Algorithm="Esdirk45a"));
      end Test_Nuclear_BOP_max;
    end Max_Production;

    package StepChange_Sim
      model Test_Nuclear_BOP_stepdemand

       parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
       parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
       parameter Integer no_modules=3;
       //parameter Real eff=0.35;

        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-94,38},{-56,76}})));
        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-94,-14},{-56,24}})));
        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-94,-66},{-54,-26}})));
        TRANSFORM.Fluid.Volumes.MixingVolume volume(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          use_T_start=false,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
              (V=0.001),
          nPorts_b=1,
          p_start=PHS.port_b_nominal.p,
          h_start=PHS.port_b_nominal.h,
          nPorts_a=3,
          showName=false)
          annotation (Placement(transformation(extent={{-42,70},{-22,90}})));
        TRANSFORM.Fluid.Volumes.MixingVolume volume1(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          use_T_start=false,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
              (V=0.001),
          nPorts_a=1,
          p_start=PHS.port_a_nominal.p,
          h_start=PHS.port_a_nominal.h,
          nPorts_b=3,
          showName=false)
          annotation (Placement(transformation(extent={{-20,-72},{-40,-52}})));
        NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
          port_a_nominal(
            p=EM.port_b2_nominal.p,
            h=EM.port_b2_nominal.h,
            m_flow=-EM.port_b2_nominal.m_flow),
          port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h), redeclare
            NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
            CS(
            p_nominal=BOP.port_a_nominal.p,
            W_totalSetpoint=SC.W_totalSetpoint_BOP,
            delayStartTCV=0))
          annotation (Placement(transformation(extent={{42,-4},{78,32}})));
         NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=1)                                     annotation (Placement(transformation(extent={{98,-4},
                  {136,32}})));
         NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{152,-2},
                  {190,32}})));
         NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_boundaries
          EM(port_a1_nominal(
            p=PHS.port_b_nominal.p,
            h=PHS.port_b_nominal.h,
            m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
            port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h))
          annotation (Placement(transformation(extent={{-10,-6},{26,32}})));

        Modelica.Blocks.Sources.Step Demand(
          height=25e06,
          offset=125e06,
          startTime=3000)
          annotation (Placement(transformation(extent={{88,54},{108,74}})));
        Components.SupervisoryControls.BOP_StepDemand SC(delayStart=0, W_nominal_BOP=1.710e08, GridDemand=Demand.y)
          annotation (Placement(transformation(extent={{122,48},{176,90}})));
      equation
        connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-56,
                64.6},{-50,64.6},{-50,79.3333},{-38,79.3333}},
                                                    color={0,127,255}));
        connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-56,
                12.6},{-46,12.6},{-46,80},{-38,80}},
                                          color={0,127,255}));
        connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-54,-38},
                {-42,-38},{-42,80.6667},{-38,80.6667}},
                                                     color={0,127,255}));
        connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-26,80},
                {-20,80},{-20,20.6},{-10,20.6}},
                                        color={0,127,255}));
        connect(EM.port_b1, volume1.port_a[1]) annotation (Line(points={{-10,5.4},
                {-16,5.4},{-16,-62},{-24,-62}},
                                           color={0,127,255}));
        connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-56,
                49.4},{-48,49.4},{-48,-62.6667},{-36,-62.6667}},
                                                      color={0,127,255}));
        connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-56,
                -2.6},{-46,-2.6},{-46,-62},{-36,-62}},
                                           color={0,127,255}));
        connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-54,-54},
                {-44,-54},{-44,-61.3333},{-36,-61.3333}},  color={0,127,255}));
        connect(EM.port_b2, BOP.port_a) annotation (Line(points={{26,20.6},{34,20.6},{
                34,21.2},{42,21.2}}, color={0,127,255}));
        connect(EM.port_a2, BOP.port_b) annotation (Line(points={{26,5.4},{34,5.4},{34,
                6.8},{42,6.8}}, color={0,127,255}));
        connect(BOP.portElec_b, SY.port_a[1])
          annotation (Line(points={{78,14},{98,14}}, color={255,0,0}));
        connect(SY.port_Grid, EG.portElec_a) annotation (Line(points={{136,14},{146,14},
                {146,15},{152,15}}, color={255,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {200,100}})),                                        Diagram(
              coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})),
          experiment(
            StopTime=5000,
            Interval=5,
            __Dymola_Algorithm="Esdirk45a"));
      end Test_Nuclear_BOP_stepdemand;
    end StepChange_Sim;

    package Demand_Daily_Sim
      model Test_Nuclear_BOP_Daily

       parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
       parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
       parameter Integer no_modules=3;
       //parameter Real eff=0.35;

        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-94,38},{-56,76}})));
        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-94,-14},{-56,24}})));
        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-94,-66},{-54,-26}})));
        TRANSFORM.Fluid.Volumes.MixingVolume volume(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          use_T_start=false,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
              (V=0.001),
          nPorts_b=1,
          p_start=PHS.port_b_nominal.p,
          h_start=PHS.port_b_nominal.h,
          nPorts_a=3,
          showName=false)
          annotation (Placement(transformation(extent={{-42,70},{-22,90}})));
        TRANSFORM.Fluid.Volumes.MixingVolume volume1(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          use_T_start=false,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
              (V=0.001),
          nPorts_a=1,
          p_start=PHS.port_a_nominal.p,
          h_start=PHS.port_a_nominal.h,
          nPorts_b=3,
          showName=false)
          annotation (Placement(transformation(extent={{-20,-72},{-40,-52}})));
        NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
          port_a_nominal(
            p=EM.port_b2_nominal.p,
            h=EM.port_b2_nominal.h,
            m_flow=-EM.port_b2_nominal.m_flow),
          port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h), redeclare
            NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
            CS(
            p_nominal=BOP.port_a_nominal.p,
            W_totalSetpoint=SC.W_totalSetpoint_BOP,
            delayStartTCV=0))
          annotation (Placement(transformation(extent={{42,-4},{78,32}})));
         NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=1)                                     annotation (Placement(transformation(extent={{98,-4},
                  {136,32}})));
         NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{152,-2},
                  {190,32}})));
         NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_boundaries
          EM(port_a1_nominal(
            p=PHS.port_b_nominal.p,
            h=PHS.port_b_nominal.h,
            m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
            port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h))
          annotation (Placement(transformation(extent={{-10,-6},{26,32}})));

        Components.SupervisoryControls.BOP_DailyDemand SC(delayStart=0, W_nominal_BOP=1.710e08)
          annotation (Placement(transformation(extent={{122,48},{176,90}})));
      equation
        connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-56,
                64.6},{-50,64.6},{-50,79.3333},{-38,79.3333}},
                                                    color={0,127,255}));
        connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-56,
                12.6},{-46,12.6},{-46,80},{-38,80}},
                                          color={0,127,255}));
        connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-54,-38},
                {-42,-38},{-42,80.6667},{-38,80.6667}},
                                                     color={0,127,255}));
        connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-26,80},
                {-20,80},{-20,20.6},{-10,20.6}},
                                        color={0,127,255}));
        connect(EM.port_b1, volume1.port_a[1]) annotation (Line(points={{-10,5.4},
                {-16,5.4},{-16,-62},{-24,-62}},
                                           color={0,127,255}));
        connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-56,
                49.4},{-48,49.4},{-48,-62.6667},{-36,-62.6667}},
                                                      color={0,127,255}));
        connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-56,
                -2.6},{-46,-2.6},{-46,-62},{-36,-62}},
                                           color={0,127,255}));
        connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-54,-54},
                {-44,-54},{-44,-61.3333},{-36,-61.3333}},  color={0,127,255}));
        connect(EM.port_b2, BOP.port_a) annotation (Line(points={{26,20.6},{34,20.6},{
                34,21.2},{42,21.2}}, color={0,127,255}));
        connect(EM.port_a2, BOP.port_b) annotation (Line(points={{26,5.4},{34,5.4},{34,
                6.8},{42,6.8}}, color={0,127,255}));
        connect(BOP.portElec_b, SY.port_a[1])
          annotation (Line(points={{78,14},{98,14}}, color={255,0,0}));
        connect(SY.port_Grid, EG.portElec_a) annotation (Line(points={{136,14},{146,14},
                {146,15},{152,15}}, color={255,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {200,100}})),                                        Diagram(
              coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})),
          experiment(
            StopTime=86400,
            Interval=3600,
            __Dymola_Algorithm="Esdirk45a"));
      end Test_Nuclear_BOP_Daily;
    end Demand_Daily_Sim;
  end ElectricityProductn;

  package Electricity_HydrogenProduction
    model Test_Nuclear_BOP_HTSE_stepdemand

     parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
     parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
     parameter Integer no_modules=3;
    // parameter Real eff=0.35;

      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-94,40},{-56,78}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-94,-10},{-56,28}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-94,-64},{-54,-24}})));
      NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
        port_a_nominal(
          p=EM.port_b2_nominal.p,
          h=EM.port_b2_nominal.h,
          m_flow=-EM.port_b2_nominal.m_flow),
        port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h), redeclare
          NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
          CS(
          p_nominal=BOP.port_a_nominal.p,
          W_totalSetpoint=SC.W_totalSetpoint_BOP,
          delayStartTCV=0), nPorts_a3=1)
        annotation (Placement(transformation(extent={{42,2},{78,38}})));
       NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=2)                                     annotation (Placement(transformation(extent={{110,2},
                {148,38}})));
       NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{162,4},
                {200,38}})));
       NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_boundaries
        EM(port_a1_nominal(
          p=PHS.port_b_nominal.p,
          h=PHS.port_b_nominal.h,
          m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
          port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
        nPorts_b3=1)
        annotation (Placement(transformation(extent={{-8,0},{28,38}})));

      Modelica.Blocks.Sources.Step Demand(
        height=25e06,
        offset=125e06,
        startTime=3000)
        annotation (Placement(transformation(extent={{144,-42},{164,-22}})));
      Journal_IES_Simulations.Components.SupervisoryControls.BOP_HTSE_StepDemand SC(
       delayStart=0, W_nominal_BOP= 1.710e08,
       Elec_Demand=Demand.y)
        annotation (Placement(transformation(extent={{126,50},{180,100}})));
      Components.HTSE.SteamControl.HTSESteamFlowCtrl_GenericModular
        IP(
        capacity=51.1454e6,
        redeclare
          Components.HTSE.SteamControl.CS_TightlyCoupled_SteamFlowCtrl_modified CS(
          capacityScaler=IP.capacityScaler,
          delayStart=10,
          W_totalSetpoint=SC.W_totalSetpoint_IP),
        port_a_nominal(m_flow=IP.capacityScaler_steamFlow*9.0942),
        hEX_nuclearHeatAnodeGasRecup_ROM(TTube_out(start=259 + 273.15, fixed=false)),
        returnPump(PR0=62.7/43.1794))
        annotation (Placement(transformation(extent={{60,-48},{102,-8}})));

      TRANSFORM.Fluid.Volumes.MixingVolume volume2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume,
        nPorts_a=3,
        nPorts_b=1)
        annotation (Placement(transformation(extent={{-42,58},{-22,78}})));

      TRANSFORM.Fluid.Volumes.MixingVolume volume3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume,
        nPorts_a=3,
        nPorts_b=1)
        annotation (Placement(transformation(extent={{-30,-62},{-10,-42}})));

    equation
      connect(EM.port_b2, BOP.port_a) annotation (Line(points={{28,26.6},{34,26.6},{
              34,27.2},{42,27.2}}, color={0,127,255}));
      connect(EM.port_a2, BOP.port_b) annotation (Line(points={{28,11.4},{34,11.4},{
              34,12.8},{42,12.8}},
                              color={0,127,255}));
      connect(BOP.portElec_b, SY.port_a[1])
        annotation (Line(points={{78,20},{98,20},{98,19.1},{110,19.1}},
                                                   color={255,0,0}));
      connect(EM.port_b3[1], IP.port_a) annotation (Line(points={{17.2,0},{16,0},{16,
              -20},{60,-20}},    color={0,127,255}));
      connect(BOP.port_a3[1], IP.port_b) annotation (Line(points={{52.8,2},{52.8,-36},
              {60,-36}},          color={0,127,255}));
      connect(SY.port_Grid, EG.portElec_a) annotation (Line(points={{148,20},{158,20},
              {158,21},{162,21}}, color={255,0,0}));
      connect(IP.portElec_a, SY.port_a[2]) annotation (Line(points={{102,-28},{102,20.9},
              {110,20.9}},            color={255,0,0}));
      connect(PHS.port_b, volume2.port_a[1]) annotation (Line(points={{-56,66.6},
              {-47,66.6},{-47,67.3333},{-38,67.3333}}, color={0,127,255}));
      connect(PHS1.port_b, volume2.port_a[2]) annotation (Line(points={{-56,
              16.6},{-48,16.6},{-48,68},{-38,68}}, color={0,127,255}));
      connect(PHS2.port_b, volume2.port_a[3]) annotation (Line(points={{-54,-36},
              {-46,-36},{-46,68.6667},{-38,68.6667}}, color={0,127,255}));
      connect(volume2.port_b[1], EM.port_a1) annotation (Line(points={{-26,68},
              {-18,68},{-18,26.6},{-8,26.6}}, color={0,127,255}));
      connect(PHS.port_a, volume3.port_a[1]) annotation (Line(points={{-56,51.4},
              {-44,51.4},{-44,-52.6667},{-26,-52.6667}}, color={0,127,255}));
      connect(PHS1.port_a, volume3.port_a[2]) annotation (Line(points={{-56,1.4},
              {-44,1.4},{-44,-52},{-26,-52}}, color={0,127,255}));
      connect(PHS2.port_a, volume3.port_a[3]) annotation (Line(points={{-54,-52},
              {-40,-52},{-40,-51.3333},{-26,-51.3333}}, color={0,127,255}));
      connect(volume3.port_b[1], EM.port_b1) annotation (Line(points={{-14,-52},
              {-12,-52},{-12,11.4},{-8,11.4}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {200,100}})),                                        Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})),
        experiment(
          StopTime=5000,
          Interval=60,
          __Dymola_Algorithm="Esdirk23a"));
    end Test_Nuclear_BOP_HTSE_stepdemand;

    model Test_Nuclear_BOP_HTSE_DailyDemand

     parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
     parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
     parameter Integer no_modules=3;
    // parameter Real eff=0.35;

      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-94,40},{-56,78}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-94,-10},{-56,28}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-94,-64},{-54,-24}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        nPorts_b=1,
        p_start=PHS.port_b_nominal.p,
        h_start=PHS.port_b_nominal.h,
        nPorts_a=3,
        showName=false)
        annotation (Placement(transformation(extent={{-42,72},{-22,92}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        nPorts_a=1,
        p_start=PHS.port_a_nominal.p,
        h_start=PHS.port_a_nominal.h,
        nPorts_b=3,
        showName=false)
        annotation (Placement(transformation(extent={{-20,-68},{-40,-48}})));
      NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
        port_a_nominal(
          p=EM.port_b2_nominal.p,
          h=EM.port_b2_nominal.h,
          m_flow=-EM.port_b2_nominal.m_flow),
        port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h), redeclare
          NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
          CS(
          p_nominal=BOP.port_a_nominal.p,
          W_totalSetpoint=SC.W_totalSetpoint_BOP,
          delayStartTCV=0), nPorts_a3=1)
        annotation (Placement(transformation(extent={{42,2},{78,38}})));
       NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=2)                                     annotation (Placement(transformation(extent={{110,2},
                {148,38}})));
       NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{162,4},
                {200,38}})));
       NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_boundaries
        EM(port_a1_nominal(
          p=PHS.port_b_nominal.p,
          h=PHS.port_b_nominal.h,
          m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
          port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
        nPorts_b3=1)
        annotation (Placement(transformation(extent={{-8,0},{28,38}})));

      Journal_IES_Simulations.Components.SupervisoryControls.BOP_HTSE_DailyDemand SC(
       delayStart=0, W_nominal_BOP= 1.710e08)
        annotation (Placement(transformation(extent={{126,50},{180,100}})));
      Components.HTSE.SteamControl.HTSESteamFlowCtrl_GenericModular
        IP(
        capacity=51.1454e6,
        redeclare
          Components.HTSE.SteamControl.CS_TightlyCoupled_SteamFlowCtrl_modified CS(
          capacityScaler=IP.capacityScaler,
          delayStart=10,
          W_totalSetpoint=SC.W_totalSetpoint_IP),
        port_a_nominal(m_flow=IP.capacityScaler_steamFlow*9.0942),
        hEX_nuclearHeatAnodeGasRecup_ROM(TTube_out(start=259 + 273.15, fixed=false)),
        returnPump(PR0=62.7/43.1794))
        annotation (Placement(transformation(extent={{60,-48},{102,-8}})));

    equation
      connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-56,66.6},
              {-50,66.6},{-50,81.3333},{-38,81.3333}},
                                                  color={0,127,255}));
      connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-56,16.6},{-46,
              16.6},{-46,82},{-38,82}}, color={0,127,255}));
      connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-54,-36},
              {-42,-36},{-42,82.6667},{-38,82.6667}},
                                                   color={0,127,255}));
      connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-26,82},{-20,82},
              {-20,26.6},{-8,26.6}},  color={0,127,255}));
      connect(EM.port_b1, volume1.port_a[1]) annotation (Line(points={{-8,11.4},{-16,
              11.4},{-16,-58},{-24,-58}},color={0,127,255}));
      connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-56,51.4},
              {-48,51.4},{-48,-58.6667},{-36,-58.6667}},
                                                    color={0,127,255}));
      connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-56,1.4},{-46,
              1.4},{-46,-58},{-36,-58}}, color={0,127,255}));
      connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-54,-52},
              {-44,-52},{-44,-57.3333},{-36,-57.3333}},  color={0,127,255}));
      connect(EM.port_b2, BOP.port_a) annotation (Line(points={{28,26.6},{34,26.6},{
              34,27.2},{42,27.2}}, color={0,127,255}));
      connect(EM.port_a2, BOP.port_b) annotation (Line(points={{28,11.4},{34,11.4},{
              34,12.8},{42,12.8}},
                              color={0,127,255}));
      connect(BOP.portElec_b, SY.port_a[1])
        annotation (Line(points={{78,20},{98,20},{98,19.1},{110,19.1}},
                                                   color={255,0,0}));
      connect(EM.port_b3[1], IP.port_a) annotation (Line(points={{17.2,0},{16,0},{16,
              -20},{60,-20}},    color={0,127,255}));
      connect(BOP.port_a3[1], IP.port_b) annotation (Line(points={{52.8,2},{52.8,-36},
              {60,-36}},          color={0,127,255}));
      connect(SY.port_Grid, EG.portElec_a) annotation (Line(points={{148,20},{158,20},
              {158,21},{162,21}}, color={255,0,0}));
      connect(IP.portElec_a, SY.port_a[2]) annotation (Line(points={{102,-28},{102,20.9},
              {110,20.9}},            color={255,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {200,100}})),                                        Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})),
        experiment(
          StopTime=86400,
          Interval=3600,
          __Dymola_Algorithm="Esdirk45a"));
    end Test_Nuclear_BOP_HTSE_DailyDemand;
  end Electricity_HydrogenProduction;

  package WindGeneratn_ElectricityProd
    model Test_NuclearWind_BOP_stepdemand

     parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
     parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
     parameter Integer no_modules=3;
     //parameter Real eff=0.35;

      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-96,32},{-58,70}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-96,-20},{-58,18}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-96,-68},{-56,-28}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        nPorts_b=1,
        p_start=PHS.port_b_nominal.p,
        h_start=PHS.port_b_nominal.h,
        nPorts_a=3,
        showName=false)
        annotation (Placement(transformation(extent={{-42,70},{-22,90}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        nPorts_a=1,
        p_start=PHS.port_a_nominal.p,
        h_start=PHS.port_a_nominal.h,
        nPorts_b=3,
        showName=false)
        annotation (Placement(transformation(extent={{-20,-72},{-40,-52}})));
      NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
        port_a_nominal(
          p=EM.port_b2_nominal.p,
          h=EM.port_b2_nominal.h,
          m_flow=-EM.port_b2_nominal.m_flow),
        port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h), redeclare
          NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
          CS(
          p_nominal=BOP.port_a_nominal.p,
          W_totalSetpoint=SC.W_totalSetpoint_BOP,
          delayStartTCV=0))
        annotation (Placement(transformation(extent={{42,-4},{78,32}})));
       NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=2)                                     annotation (Placement(transformation(extent={{98,-4},
                {136,32}})));
       NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{152,-2},
                {190,32}})));
       NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_boundaries
        EM(port_a1_nominal(
          p=PHS.port_b_nominal.p,
          h=PHS.port_b_nominal.h,
          m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
          port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h))
        annotation (Placement(transformation(extent={{-12,-6},{24,32}})));

      Modelica.Blocks.Sources.Step Demand(
        height=25e06,
        offset=125e06,
        startTime=3000)
        annotation (Placement(transformation(extent={{164,-78},{190,-52}})));
      Components.SupervisoryControls.Wind_BOP_StepDemand SC(delayStart=0, W_nominal_BOP= 1.710e08,
       Elec_Demand=Demand.y, Wind_Power=windPlant_MultiInstantiate_Hours.WindPower)
        annotation (Placement(transformation(extent={{140,42},{192,90}})));
      Components.WindPlant.WindPlant_MultiInstantiate_Hours
        windPlant_MultiInstantiate_Hours
        annotation (Placement(transformation(extent={{12,50},{42,84}})));
      Components.WindPlant.Wind_connector_Transform wind_connector_Transform
        annotation (Placement(transformation(extent={{56,36},{78,80}})));
    equation
      connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-58,58.6},
              {-50,58.6},{-50,79.3333},{-38,79.3333}},
                                                  color={0,127,255}));
      connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-58,6.6},
              {-46,6.6},{-46,80},{-38,80}},
                                        color={0,127,255}));
      connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-56,-40},
              {-42,-40},{-42,80.6667},{-38,80.6667}},
                                                   color={0,127,255}));
      connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-26,80},{-20,80},
              {-20,20.6},{-12,20.6}}, color={0,127,255}));
      connect(EM.port_b1, volume1.port_a[1]) annotation (Line(points={{-12,5.4},{-16,
              5.4},{-16,-62},{-24,-62}}, color={0,127,255}));
      connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-58,43.4},
              {-48,43.4},{-48,-62.6667},{-36,-62.6667}},
                                                    color={0,127,255}));
      connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-58,
              -8.6},{-46,-8.6},{-46,-62},{-36,-62}},
                                         color={0,127,255}));
      connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-56,-56},
              {-44,-56},{-44,-61.3333},{-36,-61.3333}},  color={0,127,255}));
      connect(EM.port_b2, BOP.port_a) annotation (Line(points={{24,20.6},{34,20.6},{
              34,21.2},{42,21.2}}, color={0,127,255}));
      connect(EM.port_a2, BOP.port_b) annotation (Line(points={{24,5.4},{34,5.4},{34,
              6.8},{42,6.8}}, color={0,127,255}));
      connect(BOP.portElec_b, SY.port_a[1])
        annotation (Line(points={{78,14},{88,14},{88,13.1},{98,13.1}},
                                                   color={255,0,0}));
      connect(SY.port_Grid, EG.portElec_a) annotation (Line(points={{136,14},{146,14},
              {146,15},{152,15}}, color={255,0,0}));
      connect(windPlant_MultiInstantiate_Hours.WindPower, wind_connector_Transform.powerGeneration)
        annotation (Line(points={{43.6667,62.58},{49.8333,62.58},{49.8333,62.84},
              {56,62.84}},
                       color={0,0,127}));
      connect(wind_connector_Transform.portElec_a, SY.port_a[2]) annotation (Line(
            points={{78,62.4},{88,62.4},{88,14.9},{98,14.9}}, color={255,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {200,100}})),                                        Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})),
        experiment(
          StopTime=5000,
          Interval=60,
          __Dymola_Algorithm="Esdirk23a"));
    end Test_NuclearWind_BOP_stepdemand;
  end WindGeneratn_ElectricityProd;

  package HTSE_Sim
    model Trial_HYBRIDHTSE_PWRbased_PowerCtrl
      import NHES.Electrolysis;
      import NHES;
      extends Modelica.Icons.Example;

      NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.TightlyCoupled_PowerCtrl
        IP(
        redeclare
          NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.CS_TightlyCoupled_PowerCtrl
          CS,
        hEX_nuclearHeatAnodeGasRecup_ROM(TTube_out(start=259 + 273.15, fixed=false)),
        TCV_anodeGas(m_flow(start=2.61448, fixed=false)),
        returnPump(PR0=62.7/43.1794))
        annotation (Placement(transformation(extent={{-30,-30},{30,30}})));

      Modelica.Fluid.Sources.Boundary_pT sink(
        nPorts=1,
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        T(displayUnit="degC") = 488.293,
        p(displayUnit="bar") = 6270000)
        annotation (Placement(transformation(extent={{-66,-2},{-46,-22}})));
      Modelica.Fluid.Sources.MassFlowSource_T source(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        nPorts=1,
        m_flow=9.0942,
        T(displayUnit="degC") = 591,
        use_m_flow_in=true)
        annotation (Placement(transformation(extent={{-66,2},{-46,22}})));
      Modelica.Blocks.Sources.Ramp m_flow_in_stepInput(
        startTime=1000,
        duration=0,
        height=(6.84844 - 9.0942),
        offset=9.0942)
        annotation (Placement(transformation(extent={{-108,10},{-88,30}})));
      NHES.Electrical.Grid grid(
        n=1,
        f_nominal=60,
        Q_nominal=1e11,
        droop=0.5)
        annotation (Placement(transformation(extent={{48,-10},{68,10}})));
    equation
      connect(sink.ports[1], IP.port_b)
        annotation (Line(points={{-46,-12},{-30,-12}}, color={0,127,255}));
      connect(IP.port_a, source.ports[1])
        annotation (Line(points={{-30,12},{-46,12}}, color={0,127,255}));
      connect(source.m_flow_in, m_flow_in_stepInput.y)
        annotation (Line(points={{-66,20},{-87,20}}, color={0,0,127}));
      connect(grid.ports[1], IP.portElec_a)
        annotation (Line(points={{48,0},{30,0}}, color={255,0,0}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
                -100},{100,100}})),
        experiment(
          StopTime=7200,
          __Dymola_NumberOfIntervals=1800,
          __Dymola_Algorithm="Esdirk45a"),
        __Dymola_experimentSetupOutput(events=false),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{
                100,100}})),
        __Dymola_experimentFlags(
          Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
          Evaluate=false,
          OutputCPUtime=false,
          OutputFlatModelica=false));
    end Trial_HYBRIDHTSE_PWRbased_PowerCtrl;

    model Trial_GenericModularbased_PowerCtrl_OldLoad
      import NHES.Electrolysis;
      import NHES;
      extends Modelica.Icons.Example;

      Journal_IES_Simulations.Components.HTSE.PowerControl.HTSEPowerCtrl_GenericModular_OldLoad
        IP(
        redeclare
          Journal_IES_Simulations.Components.HTSE.PowerControl.CS_TightlyCoupled_PowerCtrl
          CS,
        hEX_nuclearHeatAnodeGasRecup_ROM(TTube_out(start=259 + 273.15, fixed=false)),
        TCV_anodeGas(m_flow(start=2.61448, fixed=false)),
        returnPump(PR0=35/43.1794))
        annotation (Placement(transformation(extent={{-30,-30},{30,30}})));

      Modelica.Fluid.Sources.Boundary_pT sink(
        nPorts=1,
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        T(displayUnit="degC") = 473.119,
        p(displayUnit="bar") = 3928000)
        annotation (Placement(transformation(extent={{-68,-2},{-48,-22}})));
      Modelica.Fluid.Sources.MassFlowSource_T source(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        nPorts=1,
        m_flow=9.0942,
        T(displayUnit="degC") = 573.369,
        use_m_flow_in=true)
        annotation (Placement(transformation(extent={{-66,2},{-46,22}})));
      Modelica.Blocks.Sources.Ramp m_flow_in_stepInput(
        startTime=1000,
        duration=0,
        height=(4.84844 - 9.0942),
        offset=9.0942)
        annotation (Placement(transformation(extent={{-114,10},{-94,30}})));
      NHES.Electrical.Grid grid(
        n=1,
        f_nominal=60,
        Q_nominal=1e11,
        droop=0.5) annotation (Placement(transformation(extent={{48,-10},{68,10}})));
      Modelica.Blocks.Sources.Ramp m_flow_in_stepInput1(
        startTime=1000,
        duration=0,
        height=(6.84844 - 9.0942),
        offset=9.0942)
        annotation (Placement(transformation(extent={{-114,-80},{-94,-60}})));
    equation
      connect(sink.ports[1], IP.port_b)
        annotation (Line(points={{-48,-12},{-30,-12}}, color={0,127,255}));
      connect(IP.port_a, source.ports[1])
        annotation (Line(points={{-30,12},{-46,12}}, color={0,127,255}));
      connect(source.m_flow_in, m_flow_in_stepInput.y)
        annotation (Line(points={{-66,20},{-93,20}}, color={0,0,127}));
      connect(grid.ports[1], IP.portElec_a)
        annotation (Line(points={{48,0},{30,0}}, color={255,0,0}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
                -100},{100,100}})),
        experiment(
          StopTime=7200,
          __Dymola_NumberOfIntervals=1800,
          __Dymola_Algorithm="Esdirk45a"),
        __Dymola_experimentSetupOutput(events=false),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{100,100}})),
        __Dymola_experimentFlags(
          Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
          Evaluate=false,
          OutputCPUtime=false,
          OutputFlatModelica=false));
    end Trial_GenericModularbased_PowerCtrl_OldLoad;

    model Test_GenericModularbased_PowerCtrl_ModifiedLoad
      import NHES.Electrolysis;
      import NHES;
      extends Modelica.Icons.Example;

      Journal_IES_Simulations.Components.HTSE.PowerControl.HTSEPowerCtrl_GenericModular
        IP(
        redeclare
          Journal_IES_Simulations.Components.HTSE.PowerControl.CS_TightlyCoupled_PowerCtrl
          CS,
        hEX_nuclearHeatAnodeGasRecup_ROM(TTube_out(start=259 + 273.15, fixed=
                false)),
        TCV_anodeGas(m_flow(start=2.61448, fixed=false)),
        returnPump(PR0=39/43.1794))
        annotation (Placement(transformation(extent={{-30,-32},{30,28}})));

      Modelica.Fluid.Sources.MassFlowSource_T source(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        nPorts=1,
        m_flow=9.0942,
        T(displayUnit="degC") = 573.369,
        use_m_flow_in=true)
        annotation (Placement(transformation(extent={{-64,30},{-44,50}})));
      Modelica.Blocks.Sources.Ramp m_flow_in_stepInput(
        startTime=0,
        duration=0,
        height=0,
        offset=9.02)
        annotation (Placement(transformation(extent={{-102,38},{-82,58}})));
      NHES.Electrical.Grid grid(
        n=1,
        f_nominal=60,
        Q_nominal=1e11,
        droop=0.5) annotation (Placement(transformation(extent={{48,-10},{68,10}})));
      Modelica.Blocks.Sources.Ramp m_flow_in_stepInput1(
        startTime=1000,
        duration=0,
        height=(6.84844 - 9.0942),
        offset=9.0942)
        annotation (Placement(transformation(extent={{-114,-80},{-94,-60}})));
      Modelica.Fluid.Sources.Boundary_ph boundary(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=3928000,
        h=9e05,
        nPorts=1)
        annotation (Placement(transformation(extent={{-78,-50},{-58,-30}})));
    equation
      connect(IP.port_a, source.ports[1])
        annotation (Line(points={{-30,10},{-40,10},{-40,40},{-44,40}},
                                                     color={0,127,255}));
      connect(source.m_flow_in, m_flow_in_stepInput.y)
        annotation (Line(points={{-64,48},{-81,48}}, color={0,0,127}));
      connect(grid.ports[1], IP.portElec_a)
        annotation (Line(points={{48,0},{40,0},{40,-2},{30,-2}},
                                                 color={255,0,0}));
      connect(boundary.ports[1], IP.port_b) annotation (Line(points={{-58,-40},
              {-44,-40},{-44,-14},{-30,-14}}, color={0,127,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
                -100},{100,100}})),
        experiment(
          StopTime=7200,
          __Dymola_NumberOfIntervals=1800,
          __Dymola_Algorithm="Esdirk45a"),
        __Dymola_experimentSetupOutput(events=false),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{100,100}})),
        __Dymola_experimentFlags(
          Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
          Evaluate=false,
          OutputCPUtime=false,
          OutputFlatModelica=false));
    end Test_GenericModularbased_PowerCtrl_ModifiedLoad;

    model Trial_HYBRIDHTSE_PWRbased_SteamFlowCtrl
      import NHES.Electrolysis;
      import NHES;
      extends Modelica.Icons.Example;

      Modelica.Fluid.Sources.Boundary_pT heatingMedium_in(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_p_in=false,
        p=5800000,
        T=591.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-78,20},{-60,38}})));
      Modelica.Fluid.Sources.Boundary_pT heatingMedium_out(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        nPorts=1,
        p=6270000,
        T=488.896) annotation (Placement(transformation(
            extent={{9,9},{-9,-9}},
            rotation=180,
            origin={-67,-22})));
      NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.TightlyCoupled_SteamFlowCtrl
        IP(
        capacity=dataCapacity.IP_capacity,
        redeclare
          NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.CS_TightlyCoupled_SteamFlowCtrl_stepInput
          CS(capacityScaler=IP.capacityScaler),
        port_a_nominal(m_flow=IP.capacityScaler_steamFlow*9.0942),
        hEX_nuclearHeatAnodeGasRecup_ROM(TTube_out(start=259 + 273.15, fixed=false)),
        returnPump(PR0=62.7/43.1794))
        annotation (Placement(transformation(extent={{-32,-34},{32,34}})));

      NHES.Systems.Examples.BaseClasses.Data_Capacity
                                dataCapacity(
                    SES_capacity(displayUnit="MW"), IP_capacity(displayUnit="MW")=
             70000000)
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      NHES.Electrical.Grid        grid(
                         n=1,
        f_nominal=60,
        Q_nominal=1e11,
        droop=0.5)
                 annotation (Placement(transformation(extent={{48,-8},{68,12}})));
    equation
      connect(heatingMedium_in.ports[1], IP.port_a) annotation (Line(points={{-60,29},
              {-32,29},{-32,13.6}},     color={0,127,255}));
      connect(heatingMedium_out.ports[1], IP.port_b) annotation (Line(points={{-58,-22},
              {-32,-22},{-32,-13.6}},      color={0,127,255}));
      connect(IP.portElec_a, grid.ports[1])
        annotation (Line(points={{32,0},{40,0},{40,2},{48,2}},
                                                 color={255,0,0}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})),
        experiment(
          StopTime=4000,
          __Dymola_NumberOfIntervals=4000,
          __Dymola_Algorithm="Esdirk45a"),
        __Dymola_experimentSetupOutput,
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
    end Trial_HYBRIDHTSE_PWRbased_SteamFlowCtrl;

    model Trial_GenericModularbased_SteamFlowCtrl
      import NHES.Electrolysis;
      import NHES;
      extends Modelica.Icons.Example;

      Journal_IES_Simulations.Components.HTSE.SteamControl.HTSESteamFlowCtrl_GenericModular
        IP(
        capacity=dataCapacity.IP_capacity,
        redeclare
          Journal_IES_Simulations.Components.HTSE.SteamControl.CS_TightlyCoupled_SteamFlowCtrl_modified
          CS(capacityScaler=IP.capacityScaler,delayStart=10,W_totalSetpoint=Powerset.y),
        port_a_nominal(m_flow=IP.capacityScaler_steamFlow*9.0942),
        hEX_nuclearHeatAnodeGasRecup_ROM(TTube_out(start=259 + 273.15, fixed=false)),
        returnPump(PR0=62.7/43.1794))
        annotation (Placement(transformation(extent={{-32,-34},{32,34}})));

      NHES.Systems.Examples.BaseClasses.Data_Capacity
                                dataCapacity(
                    SES_capacity(displayUnit="MW"), IP_capacity(displayUnit="MW")=
             70000000)
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      Electrolysis.Sources.PrescribedPowerFlow prescribedPowerFlow annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={62,0})));
      Modelica.Blocks.Sources.Constant Powerset(k=51.5e06)
        annotation (Placement(transformation(extent={{48,16},{68,36}})));
      Modelica.Fluid.Sources.Boundary_pT heatingMedium_in(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_p_in=false,
        p=3500000,
        T=573.369,
        nPorts=1)
        annotation (Placement(transformation(extent={{-82,22},{-64,40}})));
      Modelica.Fluid.Sources.Boundary_pT heatingMedium_out(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        nPorts=1,
        p=3900000,
        T=473.119) annotation (Placement(transformation(
            extent={{9,9},{-9,-9}},
            rotation=180,
            origin={-79,-26})));
    equation
      connect(IP.portElec_a, prescribedPowerFlow.port_b)
        annotation (Line(points={{32,0},{52,0}}, color={255,0,0}));
      connect(Powerset.y, prescribedPowerFlow.P_flow)
        annotation (Line(points={{69,26},{84,26},{84,0},{70,0}}, color={0,0,127}));
      connect(heatingMedium_in.ports[1], IP.port_a) annotation (Line(points={{-64,31},
              {-48,31},{-48,13.6},{-32,13.6}}, color={0,127,255}));
      connect(heatingMedium_out.ports[1], IP.port_b) annotation (Line(points={{-70,-26},
              {-48,-26},{-48,-13.6},{-32,-13.6}}, color={0,127,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})),
        experiment(
          StopTime=4000,
          __Dymola_NumberOfIntervals=4000,
          __Dymola_Algorithm="Esdirk45a"),
        __Dymola_experimentSetupOutput,
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
    end Trial_GenericModularbased_SteamFlowCtrl;

    model Trial_threeCoupled_dumbHTSE_EMValves_Manual
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-128,42},{-74,96}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-128,-20},{-74,34}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-128,-82},{-74,-28}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        p_start=PHS.port_b_nominal.p,
        h_start=PHS.port_b_nominal.h,
        nPorts_a=3,
        showName=false,
        nPorts_b=1)
        annotation (Placement(transformation(extent={{-46,86},{-26,106}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        p_start=PHS.port_a_nominal.p,
        h_start=PHS.port_a_nominal.h,
        nPorts_b=3,
        showName=false,
        nPorts_a=1)
        annotation (Placement(transformation(extent={{-24,-94},{-44,-74}})));

      NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
        port_a_nominal(
          p=EM.port_b2_nominal.p,
          h=EM.port_b2_nominal.h,
          m_flow=-EM.port_b2_nominal.m_flow),
        port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
        redeclare
          NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
          CS(
          p_nominal=BOP.port_a_nominal.p,
          W_totalSetpoint=Demand.y,
          delayStartTCV=0))
        annotation (Placement(transformation(extent={{84,-10},{140,46}})));
      Modelica.Fluid.Sources.Boundary_pT sink_3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p(displayUnit="bar") = 3500000,
        T(displayUnit="degC") = 573.369,
        nPorts=1) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={70,-50})));
      Modelica.Blocks.Sources.Step Demand(
        height=25e06,
        offset=125e06,
        startTime=3000)
        annotation (Placement(transformation(extent={{174,-62},{194,-42}})));
      NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG
        annotation (Placement(transformation(extent={{166,-8},{218,42}})));
    //  NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_valves EM(port_a1_nominal(
    //       p=PHS.port_b_nominal.p,
    //       h=PHS.port_b_nominal.h,
    //       m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
    //     port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
    //       nPorts_b3=1,    redeclare
    //       Journal_1_NHES.Components.EnergyManifold_PlantnControl.IPMassflowSetpoint_BOPValveOpposingControl
    //       CS(
    //       m_nominal=9.02,
    //       mflow_Actual=9.02,
    //       mflow_Setpoint=9.02))
      Journal_IES_Simulations.Components.EM.SteamManifold_L1_valves_manual EM(
        port_a1_nominal(
          p=PHS.port_b_nominal.p,
          h=PHS.port_b_nominal.h,
          m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
        port_b1_nominal(p=3.9e06, h=9e05),
        nPorts_b3=1)
        annotation (Placement(transformation(extent={{2,-12},{62,48}})));

    equation
      connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-74,79.8},
              {-61,79.8},{-61,95.3333},{-42,95.3333}},
                                                  color={0,127,255}));
      connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-74,17.8},{-64,
              17.8},{-64,96},{-42,96}}, color={0,127,255}));
      connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-74,
              -44.2},{-66,-44.2},{-66,96.6667},{-42,96.6667}},
                                                   color={0,127,255}));
      connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-74,58.2},
              {-64,58.2},{-64,-84.6667},{-40,-84.6667}},
                                                    color={0,127,255}));
      connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-74,
              -3.8},{-74,-4},{-62,-4},{-62,-84},{-40,-84}},color={0,127,255}));
      connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-74,
              -65.8},{-60,-65.8},{-60,-83.3333},{-40,-83.3333}},
                                                         color={0,127,255}));
      connect(BOP.portElec_b, EG.portElec_a) annotation (Line(points={{140,18},{164,
              18},{164,17},{166,17}}, color={255,0,0}));
      connect(EM.port_b2, BOP.port_a) annotation (Line(points={{62,30},{69,30},{69,29.2},
              {84,29.2}}, color={0,127,255}));
      connect(EM.port_a2, BOP.port_b) annotation (Line(points={{62,6},{70,6},{70,6.8},
              {84,6.8}}, color={0,127,255}));
      connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-30,96},{-18,96},
              {-18,30},{2,30}}, color={0,127,255}));
      connect(volume1.port_a[1], EM.port_b1) annotation (Line(points={{-28,-84},
              {-18,-84},{-18,6},{2,6}},
                                   color={0,127,255}));
      connect(EM.port_b3[1], sink_3.ports[1])
        annotation (Line(points={{44,-12},{44,-50},{60,-50}}, color={0,127,255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{220,
                120}})),
        experiment(
          StopTime=5000,
          __Dymola_NumberOfIntervals=2000,
          __Dymola_Algorithm="Esdirk45a"),
        __Dymola_experimentSetupOutput(events=false),
        Icon(coordinateSystem(extent={{-140,-100},{220,120}})));
    end Trial_threeCoupled_dumbHTSE_EMValves_Manual;

    model Trial_threeCoupled_dumbHTSE_EMValves_IPControl_NOBOP
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-128,42},{-74,96}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-128,-20},{-74,34}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-128,-90},{-74,-36}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        p_start=PHS.port_b_nominal.p,
        h_start=PHS.port_b_nominal.h,
        nPorts_a=3,
        showName=false,
        nPorts_b=1)
        annotation (Placement(transformation(extent={{-46,86},{-26,106}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        p_start=PHS.port_a_nominal.p,
        h_start=PHS.port_a_nominal.h,
        nPorts_b=3,
        showName=false,
        nPorts_a=1)
        annotation (Placement(transformation(extent={{-26,-94},{-46,-74}})));

      NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
        port_a_nominal(
          p=EM.port_b2_nominal.p,
          h=EM.port_b2_nominal.h,
          m_flow=-EM.port_b2_nominal.m_flow),
        port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
        redeclare
          NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
          CS(
          p_nominal=BOP.port_a_nominal.p,
          W_totalSetpoint=150e06,
          delayStartTCV=0))
        annotation (Placement(transformation(extent={{84,-10},{140,46}})));
      Modelica.Fluid.Sources.Boundary_pT sink_3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p(displayUnit="bar") = 3500000,
        T(displayUnit="degC") = 573.369,
        nPorts=1) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={70,-50})));
      NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG
        annotation (Placement(transformation(extent={{166,-8},{218,42}})));
    //  NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_valves EM(port_a1_nominal(
    //       p=PHS.port_b_nominal.p,
    //       h=PHS.port_b_nominal.h,
    //       m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
    //     port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
    //       nPorts_b3=1,    redeclare
    //       Journal_1_NHES.Components.EnergyManifold_PlantnControl.IPMassflowSetpoint_BOPValveOpposingControl
    //       CS(
    //       m_nominal=9.02,
    //       mflow_Actual=9.02,
    //       mflow_Setpoint=9.02))
      Journal_IES_Simulations.Components.EM.SteamManifold_L1_valves EM(
        port_a1_nominal(
          p=PHS.port_b_nominal.p,
          h=PHS.port_b_nominal.h,
          m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
        port_b1_nominal(p=3.9e06, h=9e05),
        nPorts_b3=1, redeclare
        Journal_IES_Simulations.Components.EM.IPMassflowSetpoint_BOPValveOpposingControl
        CS(
          m_nominal=9.02,
          mflow_Actual=sink_3.ports[1].m_flow,
          mflow_Setpoint=9.02))
        annotation (Placement(transformation(extent={{2,-12},{62,48}})));

    equation
      connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-74,79.8},
              {-61,79.8},{-61,95.3333},{-42,95.3333}},
                                                  color={0,127,255}));
      connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-74,17.8},{-64,
              17.8},{-64,96},{-42,96}}, color={0,127,255}));
      connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-74,
              -52.2},{-66,-52.2},{-66,96.6667},{-42,96.6667}},
                                                   color={0,127,255}));
      connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-74,58.2},
              {-60,58.2},{-60,-84.6667},{-42,-84.6667}},
                                                    color={0,127,255}));
      connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-74,-3.8},{-74,
              -4},{-58,-4},{-58,-84},{-42,-84}},           color={0,127,255}));
      connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-74,
              -73.8},{-56,-73.8},{-56,-83.3333},{-42,-83.3333}},
                                                         color={0,127,255}));
      connect(BOP.portElec_b, EG.portElec_a) annotation (Line(points={{140,18},{164,
              18},{164,17},{166,17}}, color={255,0,0}));
      connect(EM.port_b2, BOP.port_a) annotation (Line(points={{62,30},{69,30},{69,29.2},
              {84,29.2}}, color={0,127,255}));
      connect(EM.port_a2, BOP.port_b) annotation (Line(points={{62,6},{70,6},{70,6.8},
              {84,6.8}}, color={0,127,255}));
      connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-30,96},{-18,96},
              {-18,30},{2,30}}, color={0,127,255}));
      connect(volume1.port_a[1], EM.port_b1) annotation (Line(points={{-30,-84},{-18,
              -84},{-18,6},{2,6}}, color={0,127,255}));
      connect(EM.port_b3[1], sink_3.ports[1])
        annotation (Line(points={{44,-12},{44,-50},{60,-50}}, color={0,127,255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{220,
                120}})),
        experiment(
          StopTime=5000,
          __Dymola_NumberOfIntervals=2000,
          __Dymola_Algorithm="Esdirk45a"),
        __Dymola_experimentSetupOutput(events=false),
        Icon(coordinateSystem(extent={{-140,-100},{220,120}})));
    end Trial_threeCoupled_dumbHTSE_EMValves_IPControl_NOBOP;

    model Trial_threeCoupled_DumbHTSE_EMValves_IPControl_BOPIn
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-128,42},{-74,96}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-128,-20},{-74,34}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-128,-90},{-74,-36}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        p_start=PHS.port_b_nominal.p,
        h_start=PHS.port_b_nominal.h,
        nPorts_a=3,
        showName=false,
        nPorts_b=1)
        annotation (Placement(transformation(extent={{-52,86},{-32,106}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        p_start=PHS.port_a_nominal.p,
        h_start=PHS.port_a_nominal.h,
        nPorts_b=3,
        showName=false,
        nPorts_a=1)
        annotation (Placement(transformation(extent={{-30,-92},{-50,-72}})));

      NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
        port_a_nominal(
          p=EM.port_b2_nominal.p,
          h=EM.port_b2_nominal.h,
          m_flow=-EM.port_b2_nominal.m_flow),
        port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
        redeclare
          NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
          CS(
          p_nominal=BOP.port_a_nominal.p,
          W_totalSetpoint=150e06,
          delayStartTCV=0),
        nPorts_a3=1)
        annotation (Placement(transformation(extent={{84,-18},{144,42}})));
      NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG
        annotation (Placement(transformation(extent={{162,-14},{214,36}})));
    //  NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_valves EM(port_a1_nominal(
    //       p=PHS.port_b_nominal.p,
    //       h=PHS.port_b_nominal.h,
    //       m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
    //     port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
    //       nPorts_b3=1,    redeclare
    //       Journal_1_NHES.Components.EnergyManifold_PlantnControl.IPMassflowSetpoint_BOPValveOpposingControl
    //       CS(
    //       m_nominal=9.02,
    //       mflow_Actual=9.02,
    //       mflow_Setpoint=9.02))
      Journal_IES_Simulations.Components.EM.SteamManifold_L1_valves EM(
        port_a1_nominal(
          p=PHS.port_b_nominal.p,
          h=PHS.port_b_nominal.h,
          m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
        port_b1_nominal(p=3.9e06, h=9e05),
                     redeclare
        Journal_IES_Simulations.Components.EM.IPMassflowSetpoint_BOPValveOpposingControl
        CS(
          m_nominal=9.02,
          mflow_Actual=sink_3.ports[1].m_flow,
          mflow_Setpoint=9.02),
        nPorts_b3=1)
        annotation (Placement(transformation(extent={{2,-18},{62,42}})));

      Modelica.Fluid.Sources.Boundary_pT sink_3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p(displayUnit="bar") = 3500000,
        T(displayUnit="degC") = 573.15,
        nPorts=1) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={66,-60})));
      Modelica.Fluid.Sources.MassFlowSource_T source_2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=9.02,
        T(displayUnit="degC") = 473.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{9,9},{-9,-9}},
            rotation=0,
            origin={125,-61})));
    equation
      connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-74,79.8},
              {-61,79.8},{-61,95.3333},{-48,95.3333}},
                                                  color={0,127,255}));
      connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-74,17.8},{-64,
              17.8},{-64,96},{-48,96}}, color={0,127,255}));
      connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-74,
              -52.2},{-66,-52.2},{-66,96.6667},{-48,96.6667}},
                                                   color={0,127,255}));
      connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-74,58.2},
              {-60,58.2},{-60,-82.6667},{-46,-82.6667}},
                                                    color={0,127,255}));
      connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-74,-3.8},{-74,
              -4},{-58,-4},{-58,-82},{-46,-82}},           color={0,127,255}));
      connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-74,
              -73.8},{-56,-73.8},{-56,-81.3333},{-46,-81.3333}},
                                                         color={0,127,255}));
      connect(BOP.portElec_b, EG.portElec_a) annotation (Line(points={{144,12},{164,
              12},{164,11},{162,11}}, color={255,0,0}));
      connect(EM.port_b2, BOP.port_a) annotation (Line(points={{62,24},{84,24}},
                          color={0,127,255}));
      connect(EM.port_a2, BOP.port_b) annotation (Line(points={{62,0},{84,0}},
                         color={0,127,255}));
      connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-36,96},{-18,96},
              {-18,24},{2,24}}, color={0,127,255}));
      connect(volume1.port_a[1], EM.port_b1) annotation (Line(points={{-34,-82},{-18,
              -82},{-18,0},{2,0}}, color={0,127,255}));
      connect(source_2.ports[1], BOP.port_a3[1]) annotation (Line(points={{116,-61},
              {102,-61},{102,-18}},             color={0,127,255}));
      connect(EM.port_b3[1], sink_3.ports[1])
        annotation (Line(points={{44,-18},{44,-60},{56,-60}}, color={0,127,255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{240,
                120}})),
        experiment(
          StopTime=5000,
          __Dymola_NumberOfIntervals=2000,
          __Dymola_Algorithm="Esdirk45a"),
        __Dymola_experimentSetupOutput(events=false),
        Icon(coordinateSystem(extent={{-140,-100},{240,120}})));
    end Trial_threeCoupled_DumbHTSE_EMValves_IPControl_BOPIn;

    model Trial_threeCoupled_decoupledHTSE_EMValves_IPControl
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-158,46},{-104,100}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-158,-26},{-104,28}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-158,-98},{-104,-44}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        p_start=PHS.port_b_nominal.p,
        h_start=PHS.port_b_nominal.h,
        nPorts_a=3,
        showName=false,
        nPorts_b=1)
        annotation (Placement(transformation(extent={{-52,88},{-32,108}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        p_start=PHS.port_a_nominal.p,
        h_start=PHS.port_a_nominal.h,
        nPorts_b=3,
        showName=false,
        nPorts_a=1)
        annotation (Placement(transformation(extent={{-26,-110},{-46,-90}})));

      NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
        port_a_nominal(
          p=EM.port_b2_nominal.p,
          h=EM.port_b2_nominal.h,
          m_flow=-EM.port_b2_nominal.m_flow),
        port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
        redeclare
          NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
          CS(
          p_nominal=BOP.port_a_nominal.p,
          W_totalSetpoint=150e06,
          delayStartTCV=10),
        nPorts_a3=1)
        annotation (Placement(transformation(extent={{84,-22},{144,38}})));
      NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG
        annotation (Placement(transformation(extent={{166,-18},{218,32}})));
    //  NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_valves EM(port_a1_nominal(
    //       p=PHS.port_b_nominal.p,
    //       h=PHS.port_b_nominal.h,
    //       m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
    //     port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
    //       nPorts_b3=1,    redeclare
    //       Journal_1_NHES.Components.EnergyManifold_PlantnControl.IPMassflowSetpoint_BOPValveOpposingControl
    //       CS(
    //       m_nominal=9.02,
    //       mflow_Actual=9.02,
    //       mflow_Setpoint=9.02))
      Journal_IES_Simulations.Components.EM.SteamManifold_L1_valves EM(
        port_a1_nominal(
          p=PHS.port_b_nominal.p,
          h=PHS.port_b_nominal.h,
          m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
        port_b1_nominal(p=3.9e06, h=9e05),
                     redeclare
        Journal_IES_Simulations.Components.EM.IPMassflowSetpoint_BOPValveOpposingControl
        CS(delayStart=100,
          m_nominal=9.02,
          mflow_Actual=sink_3.ports[1].m_flow,
          mflow_Setpoint=m_in.y),
        nPorts_b3=1)
        annotation (Placement(transformation(extent={{2,-22},{62,38}})));

      Modelica.Fluid.Sources.Boundary_pT sink_3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_p_in=false,
        use_T_in=false,
        p(displayUnit="bar") = 3500000,
        T(displayUnit="degC") = 573.15,
        nPorts=1) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={70,-100})));

      Modelica.Fluid.Sources.MassFlowSource_T source_2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=9,
        T(displayUnit="degC") = 473.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{9,9},{-9,-9}},
            rotation=0,
            origin={131,-99})));
      Modelica.Blocks.Sources.Step m_in(
        height=-1,
        offset=9,
        startTime=3000)
        annotation (Placement(transformation(extent={{132,78},{152,98}})));
    equation
      connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-104,83.8},
              {-61,83.8},{-61,97.3333},{-48,97.3333}},
                                                  color={0,127,255}));
      connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-104,
              11.8},{-64,11.8},{-64,98},{-48,98}},
                                        color={0,127,255}));
      connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-104,
              -60.2},{-66,-60.2},{-66,98.6667},{-48,98.6667}},
                                                   color={0,127,255}));
      connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-104,
              62.2},{-62,62.2},{-62,-100.667},{-42,-100.667}},
                                                    color={0,127,255}));
      connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-104,
              -9.8},{-104,-10},{-58,-10},{-58,-100},{-42,-100}},
                                                           color={0,127,255}));
      connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-104,
              -81.8},{-56,-81.8},{-56,-99.3333},{-42,-99.3333}},
                                                         color={0,127,255}));
      connect(BOP.portElec_b, EG.portElec_a) annotation (Line(points={{144,8},{
              164,8},{164,7},{166,7}},color={255,0,0}));
      connect(EM.port_b2, BOP.port_a) annotation (Line(points={{62,20},{84,20}},
                          color={0,127,255}));
      connect(EM.port_a2, BOP.port_b) annotation (Line(points={{62,-4},{84,-4}},
                         color={0,127,255}));
      connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-36,98},{
              -18,98},{-18,20},{2,20}},
                                color={0,127,255}));
      connect(volume1.port_a[1], EM.port_b1) annotation (Line(points={{-30,-100},
              {-18,-100},{-18,-4},{2,-4}},
                                   color={0,127,255}));
      connect(EM.port_b3[1], sink_3.ports[1])
        annotation (Line(points={{44,-22},{44,-100},{60,-100}},
                                                              color={0,127,255}));
      connect(source_2.ports[1], BOP.port_a3[1]) annotation (Line(points={{122,-99},
              {102,-99},{102,-22}}, color={0,127,255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-140},
                {260,120}})),
        experiment(
          StopTime=5000,
          __Dymola_NumberOfIntervals=2000,
          __Dymola_Algorithm="Esdirk45a"),
        __Dymola_experimentSetupOutput(events=false),
        Icon(coordinateSystem(extent={{-180,-140},{260,120}})));
    end Trial_threeCoupled_decoupledHTSE_EMValves_IPControl;

    model Trial_threeCoupled_HTSE_EMValves_IPControl
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-162,44},{-108,98}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-162,-22},{-108,32}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-162,-90},{-108,-36}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        p_start=PHS.port_b_nominal.p,
        h_start=PHS.port_b_nominal.h,
        nPorts_a=3,
        showName=false,
        nPorts_b=1)
        annotation (Placement(transformation(extent={{-52,86},{-32,106}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        p_start=PHS.port_a_nominal.p,
        h_start=PHS.port_a_nominal.h,
        nPorts_b=3,
        showName=false,
        nPorts_a=1)
        annotation (Placement(transformation(extent={{-30,-92},{-50,-72}})));

      NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
        port_a_nominal(
          p=EM.port_b2_nominal.p,
          h=EM.port_b2_nominal.h,
          m_flow=-EM.port_b2_nominal.m_flow),
        port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
        redeclare
          NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
          CS(
          p_nominal=BOP.port_a_nominal.p,
          W_totalSetpoint=150e06,
          delayStartTCV=10),
        nPorts_a3=1)
        annotation (Placement(transformation(extent={{84,-18},{144,42}})));
      NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG
        annotation (Placement(transformation(extent={{202,-12},{254,38}})));

      Journal_IES_Simulations.Components.EM.SteamManifold_L1_valves EM(
        port_a1_nominal(
          p=PHS.port_b_nominal.p,
          h=PHS.port_b_nominal.h,
          m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
        port_b1_nominal(p=3.9e06, h=9e05),
                     redeclare
        Journal_IES_Simulations.Components.EM.IPMassflowSetpoint_BOPValveOpposingControl
        CS(delayStart=100,
          m_nominal=9.02,
          mflow_Actual= -1*EM.port_b3[1].m_flow,
          mflow_Setpoint=m_in.y),
        nPorts_b3=1)
        annotation (Placement(transformation(extent={{2,-18},{62,42}})));

      Components.HTSE.PowerControl.HTSEPowerCtrl_GenericModular IP(
        redeclare Components.HTSE.PowerControl.CS_TightlyCoupled_PowerCtrl CS,
        hEX_nuclearHeatAnodeGasRecup_ROM(TTube_out(start=259 + 273.15, fixed=
                false)),
        TCV_anodeGas(m_flow(start=2.61448, fixed=false)),
        returnPump(PR0=39/43.1794))
        annotation (Placement(transformation(extent={{110,-188},{170,-128}})));

      NHES.Electrical.Grid grid(
        n=1,
        f_nominal=60,
        Q_nominal=1e11,
        droop=0.5) annotation (Placement(transformation(extent={{230,-168},{250,-148}})));
      Modelica.Fluid.Machines.ControlledPump pump(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p_a_nominal=3500000,
        p_b_nominal=5800000,
        m_flow_nominal=9,
        control_m_flow=true,
        use_m_flow_set=true,
        use_p_set=false)
        annotation (Placement(transformation(extent={{36,-156},{56,-136}})));
      Modelica.Blocks.Sources.Step m_in(
        height=-1,
        offset=9,
        startTime=3000)
        annotation (Placement(transformation(extent={{-34,-130},{-14,-110}})));
    equation
      connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-108,81.8},
              {-61,81.8},{-61,95.3333},{-48,95.3333}},
                                                  color={0,127,255}));
      connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-108,
              15.8},{-64,15.8},{-64,96},{-48,96}},
                                        color={0,127,255}));
      connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-108,
              -52.2},{-66,-52.2},{-66,96.6667},{-48,96.6667}},
                                                   color={0,127,255}));
      connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-108,
              60.2},{-62,60.2},{-62,-82.6667},{-46,-82.6667}},
                                                    color={0,127,255}));
      connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-108,
              -5.8},{-108,-2},{-58,-2},{-58,-82},{-46,-82}},
                                                           color={0,127,255}));
      connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-108,
              -73.8},{-56,-73.8},{-56,-81.3333},{-46,-81.3333}},
                                                         color={0,127,255}));
      connect(BOP.portElec_b, EG.portElec_a) annotation (Line(points={{144,12},{164,
              12},{164,13},{202,13}}, color={255,0,0}));
      connect(EM.port_b2, BOP.port_a) annotation (Line(points={{62,24},{84,24}},
                          color={0,127,255}));
      connect(EM.port_a2, BOP.port_b) annotation (Line(points={{62,0},{84,0}},
                         color={0,127,255}));
      connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-36,96},{-18,96},
              {-18,24},{2,24}}, color={0,127,255}));
      connect(volume1.port_a[1], EM.port_b1) annotation (Line(points={{-34,-82},{-18,
              -82},{-18,0},{2,0}}, color={0,127,255}));
      connect(IP.portElec_a, grid.ports[1]) annotation (Line(points={{170,-158},{230,
              -158}},               color={255,0,0}));
      connect(pump.port_b, IP.port_a)
        annotation (Line(points={{56,-146},{110,-146}}, color={0,127,255}));
      connect(EM.port_b3[1], pump.port_a) annotation (Line(points={{44,-18},{44,-64},
              {8,-64},{8,-146},{36,-146}},          color={0,127,255}));
      connect(IP.port_b, BOP.port_a3[1]) annotation (Line(points={{110,-170},{
              88,-170},{88,-18},{102,-18}}, color={0,127,255}));
      connect(m_in.y, pump.m_flow_set) annotation (Line(points={{-13,-120},{42,-120},
              {42,-137.8},{41,-137.8}}, color={0,0,127}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{260,
                120}})),
        experiment(
          StopTime=5000,
          __Dymola_NumberOfIntervals=2000,
          __Dymola_Algorithm="Esdirk45a"),
        __Dymola_experimentSetupOutput(events=false),
        Icon(coordinateSystem(extent={{-200,-200},{260,120}})));
    end Trial_threeCoupled_HTSE_EMValves_IPControl;

    model Test
      Modelica.Blocks.Sources.Step m_in(
        height=-1,
        offset=9,
        startTime=3000)
        annotation (Placement(transformation(extent={{-72,30},{-52,50}})));
      Modelica.Fluid.Machines.ControlledPump pump(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p_a_nominal=3500000,
        p_b_nominal=5800000,
        m_flow_nominal=9,
        control_m_flow=true,
        use_m_flow_set=true,
        use_p_set=false)
        annotation (Placement(transformation(extent={{-34,0},{-14,20}})));
      Modelica.Fluid.Sources.Boundary_pT sink_3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_p_in=false,
        use_T_in=false,
        p(displayUnit="bar") = 3500000,
        T(displayUnit="degC") = 573.15,
        nPorts=1) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=0,
            origin={-56,10})));
      Components.HTSE.PowerControl.HTSEPowerCtrl_GenericModular IP(
        redeclare Components.HTSE.PowerControl.CS_TightlyCoupled_PowerCtrl CS,
        hEX_nuclearHeatAnodeGasRecup_ROM(TTube_out(start=259 + 273.15, fixed=
                false)),
        TCV_anodeGas(m_flow(start=2.61448, fixed=false)),
        returnPump(PR0=39/43.1794))
        annotation (Placement(transformation(extent={{14,-36},{68,16}})));
      Modelica.Fluid.Sources.Boundary_ph boundary(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_p_in=false,
        use_h_in=false,
        p=3928000,
        h=9e05,
        nPorts=1)
        annotation (Placement(transformation(extent={{-66,-42},{-46,-22}})));
      NHES.Electrical.Grid grid(
        n=1,
        f_nominal=60,
        Q_nominal=1e11,
        droop=0.5) annotation (Placement(transformation(extent={{78,-20},{98,0}})));
    equation
      connect(m_in.y, pump.m_flow_set) annotation (Line(points={{-51,40},{-30,
              40},{-30,18.2},{-29,18.2}}, color={0,0,127}));
      connect(sink_3.ports[1], pump.port_a)
        annotation (Line(points={{-46,10},{-34,10}}, color={0,127,255}));
      connect(pump.port_b, IP.port_a) annotation (Line(points={{-14,10},{-2,10},
              {-2,0.4},{14,0.4}}, color={0,127,255}));
      connect(boundary.ports[1], IP.port_b) annotation (Line(points={{-46,-32},
              {-4,-32},{-4,-20.4},{14,-20.4}}, color={0,127,255}));
      connect(IP.portElec_a, grid.ports[1])
        annotation (Line(points={{68,-10},{78,-10}}, color={255,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Test;
  end HTSE_Sim;

  package EM_Sim
    model Trial_EMValves_manualControl
      Journal_IES_Simulations.Components.EM.SteamManifold_L1_valves_manual EM(
        port_a1_nominal(
          p=3.5e06,
          h=2.97e06,
          m_flow=225.14),
        port_b1_nominal(p=3.9e06, h=9e05),
        nPorts_b3=1)
        annotation (Placement(transformation(extent={{-34,-10},{26,50}})));

      Modelica.Fluid.Sources.MassFlowSource_T source_1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        m_flow=225.86,
        T(displayUnit="degC") = 573.44,
        nPorts=1)
        annotation (Placement(transformation(extent={{9,9},{-9,-9}},
            rotation=180,
            origin={-89,71})));
      Modelica.Fluid.Sources.Boundary_pT sink_1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p(displayUnit="bar") = 3928000,
        T(displayUnit="degC") = 473.119,
        nPorts=1)
        annotation (Placement(transformation(extent={{-96,-18},{-80,-34}})));
      Modelica.Fluid.Sources.Boundary_pT sink_2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p(displayUnit="bar") = 3500000,
        T(displayUnit="degC") = 573.44,
        nPorts=1)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=180,
            origin={82,74})));
      Modelica.Fluid.Sources.MassFlowSource_T source_2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        m_flow=225.86,
        T(displayUnit="degC") = 473.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{9,9},{-9,-9}},
            rotation=0,
            origin={85,-23})));
      Modelica.Fluid.Sources.Boundary_pT sink_3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p(displayUnit="bar") = 3500000,
        T(displayUnit="degC") = 573.44,
        nPorts=1)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=180,
            origin={32,-58})));
    equation
      connect(source_1.ports[1], EM.port_a1) annotation (Line(points={{-80,71},{-64,
              71},{-64,32},{-34,32}}, color={0,127,255}));
      connect(EM.port_b1, sink_1.ports[1]) annotation (Line(points={{-34,8},{-64,8},
              {-64,-26},{-80,-26}}, color={0,127,255}));
      connect(sink_2.ports[1], EM.port_b2) annotation (Line(points={{72,74},{58,74},
              {58,32},{26,32}}, color={0,127,255}));
      connect(EM.port_a2, source_2.ports[1]) annotation (Line(points={{26,8},{48,8},
              {48,-23},{76,-23}}, color={0,127,255}));
      connect(EM.port_b3[1], sink_3.ports[1])
        annotation (Line(points={{8,-10},{8,-58},{22,-58}},   color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=7200,
          __Dymola_NumberOfIntervals=5000,
          __Dymola_Algorithm="Esdirk45a"));
    end Trial_EMValves_manualControl;
  end EM_Sim;

  package WindGeneratn_HydrogenElectricity
    model Test_NuclearWind_BOP_HTSE_stepdemand

     parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
     parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
     parameter Integer no_modules=3;
    // parameter Real eff=0.35;

      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-96,34},{-58,72}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-96,-10},{-58,28}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-96,-56},{-56,-16}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        nPorts_b=1,
        p_start=PHS.port_b_nominal.p,
        h_start=PHS.port_b_nominal.h,
        nPorts_a=3,
        showName=false)
        annotation (Placement(transformation(extent={{-42,72},{-22,92}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        nPorts_a=1,
        p_start=PHS.port_a_nominal.p,
        h_start=PHS.port_a_nominal.h,
        nPorts_b=3,
        showName=false)
        annotation (Placement(transformation(extent={{-20,-68},{-40,-48}})));
      NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
        port_a_nominal(
          p=EM.port_b2_nominal.p,
          h=EM.port_b2_nominal.h,
          m_flow=-EM.port_b2_nominal.m_flow),
        port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h), redeclare
          NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
          CS(
          p_nominal=BOP.port_a_nominal.p,
          W_totalSetpoint=SC.W_totalSetpoint_BOP,
          delayStartTCV=0), nPorts_a3=1)
        annotation (Placement(transformation(extent={{42,0},{78,36}})));
       NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=3)                                     annotation (Placement(transformation(extent={{110,2},
                {148,38}})));
       NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{162,4},
                {200,38}})));
       NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_boundaries
        EM(port_a1_nominal(
          p=PHS.port_b_nominal.p,
          h=PHS.port_b_nominal.h,
          m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
          port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
        nPorts_b3=1)
        annotation (Placement(transformation(extent={{-8,0},{28,38}})));

      Modelica.Blocks.Sources.Step Demand(
        height=25e06,
        offset=125e06,
        startTime=3000)
        annotation (Placement(transformation(extent={{158,-50},{178,-30}})));
      Components.HTSE.SteamControl.HTSESteamFlowCtrl_GenericModular
        IP(
        capacity=51.1454e6,
        redeclare
          Components.HTSE.SteamControl.CS_TightlyCoupled_SteamFlowCtrl_modified CS(
          capacityScaler=IP.capacityScaler,
          delayStart=10,
          W_totalSetpoint=SC.W_totalSetpoint_IP),
        port_a_nominal(m_flow=IP.capacityScaler_steamFlow*9.0942),
        hEX_nuclearHeatAnodeGasRecup_ROM(TTube_out(start=259 + 273.15, fixed=false)),
        returnPump(PR0=62.7/43.1794))
        annotation (Placement(transformation(extent={{62,-52},{104,-12}})));

      Components.WindPlant.WindPlant_MultiInstantiate_Hours
        windPlant_MultiInstantiate_Hours
        annotation (Placement(transformation(extent={{46,56},{76,90}})));
      Components.WindPlant.Wind_connector_Transform wind_connector_Transform
        annotation (Placement(transformation(extent={{82,54},{102,74}})));
      Components.SupervisoryControls.Wind_BOP_IP_StepDemand SC(delayStart=0,W_nominal_BOP= 1.710e08,
       Elec_Demand=Demand.y,Wind_Power=windPlant_MultiInstantiate_Hours.WindPower)
        annotation (Placement(transformation(extent={{138,42},{192,92}})));
    equation
      connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-58,60.6},
              {-50,60.6},{-50,81.3333},{-38,81.3333}},
                                                  color={0,127,255}));
      connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-58,16.6},{-52,
              16.6},{-52,16},{-44,16},{-44,82},{-38,82}},
                                        color={0,127,255}));
      connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-56,-28},
              {-42,-28},{-42,82.6667},{-38,82.6667}},
                                                   color={0,127,255}));
      connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-26,82},{-20,82},
              {-20,26.6},{-8,26.6}},  color={0,127,255}));
      connect(EM.port_b1, volume1.port_a[1]) annotation (Line(points={{-8,11.4},{-16,
              11.4},{-16,-58},{-24,-58}},color={0,127,255}));
      connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-58,45.4},
              {-48,45.4},{-48,-58.6667},{-36,-58.6667}},
                                                    color={0,127,255}));
      connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-58,1.4},{-46,
              1.4},{-46,-58},{-36,-58}}, color={0,127,255}));
      connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-56,-44},
              {-44,-44},{-44,-57.3333},{-36,-57.3333}},  color={0,127,255}));
      connect(EM.port_b2, BOP.port_a) annotation (Line(points={{28,26.6},{34,26.6},{
              34,25.2},{42,25.2}}, color={0,127,255}));
      connect(EM.port_a2, BOP.port_b) annotation (Line(points={{28,11.4},{34,11.4},{
              34,10.8},{42,10.8}},
                              color={0,127,255}));
      connect(BOP.portElec_b, SY.port_a[1])
        annotation (Line(points={{78,18},{98,18},{98,18.8},{110,18.8}},
                                                   color={255,0,0}));
      connect(EM.port_b3[1], IP.port_a) annotation (Line(points={{17.2,0},{16,0},{16,
              -24},{62,-24}},    color={0,127,255}));
      connect(BOP.port_a3[1], IP.port_b) annotation (Line(points={{52.8,0},{52.8,-40},
              {62,-40}},          color={0,127,255}));
      connect(SY.port_Grid, EG.portElec_a) annotation (Line(points={{148,20},{158,20},
              {158,21},{162,21}}, color={255,0,0}));
      connect(IP.portElec_a, SY.port_a[2]) annotation (Line(points={{104,-32},{104,20},
              {110,20}},              color={255,0,0}));
      connect(windPlant_MultiInstantiate_Hours.WindPower, wind_connector_Transform.powerGeneration)
        annotation (Line(points={{77.6667,68.58},{77.7778,68.58},{77.7778,66.2},
              {82,66.2}},
                      color={0,0,127}));
      connect(wind_connector_Transform.portElec_a, SY.port_a[3]) annotation (Line(
            points={{102,66},{106,66},{106,21.2},{110,21.2}}, color={255,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {200,100}})),                                        Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})),
        experiment(
          StopTime=5000,
          Interval=60,
          __Dymola_Algorithm="Esdirk23a"));
    end Test_NuclearWind_BOP_HTSE_stepdemand;

    model Test_NuclearWind_BOP_HTSE_Dailydemand

     parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
     parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
     parameter Integer no_modules=3;
    // parameter Real eff=0.35;

      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-96,34},{-58,72}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-96,-10},{-58,28}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-96,-56},{-56,-16}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        nPorts_b=1,
        p_start=PHS.port_b_nominal.p,
        h_start=PHS.port_b_nominal.h,
        nPorts_a=3,
        showName=false)
        annotation (Placement(transformation(extent={{-42,72},{-22,92}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        nPorts_a=1,
        p_start=PHS.port_a_nominal.p,
        h_start=PHS.port_a_nominal.h,
        nPorts_b=3,
        showName=false)
        annotation (Placement(transformation(extent={{-20,-68},{-40,-48}})));
      NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
        port_a_nominal(
          p=EM.port_b2_nominal.p,
          h=EM.port_b2_nominal.h,
          m_flow=-EM.port_b2_nominal.m_flow),
        port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h), redeclare
          NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
          CS(
          p_nominal=BOP.port_a_nominal.p,
          W_totalSetpoint=SC.W_totalSetpoint_BOP,
          delayStartTCV=0), nPorts_a3=1)
        annotation (Placement(transformation(extent={{42,0},{78,36}})));
       NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=3)                                     annotation (Placement(transformation(extent={{110,2},
                {148,38}})));
       NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{162,4},
                {200,38}})));
       NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_boundaries
        EM(port_a1_nominal(
          p=PHS.port_b_nominal.p,
          h=PHS.port_b_nominal.h,
          m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
          port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
        nPorts_b3=1)
        annotation (Placement(transformation(extent={{-8,0},{28,38}})));

      Components.HTSE.SteamControl.HTSESteamFlowCtrl_GenericModular
        IP(
        capacity=51.1454e6,
        redeclare
          Components.HTSE.SteamControl.CS_TightlyCoupled_SteamFlowCtrl_modified CS(
          capacityScaler=IP.capacityScaler,
          delayStart=10,
          W_totalSetpoint=SC.W_totalSetpoint_IP),
        port_a_nominal(m_flow=IP.capacityScaler_steamFlow*9.0942),
        hEX_nuclearHeatAnodeGasRecup_ROM(TTube_out(start=259 + 273.15, fixed=false)),
        returnPump(PR0=62.7/43.1794))
        annotation (Placement(transformation(extent={{62,-52},{104,-12}})));

      Components.WindPlant.WindPlant_MultiInstantiate_Day
        windPlant_MultiInstantiate_Day
        annotation (Placement(transformation(extent={{46,54},{76,88}})));
      Components.WindPlant.Wind_connector_Transform wind_connector_Transform
        annotation (Placement(transformation(extent={{82,54},{102,74}})));
      Components.SupervisoryControls.Wind_BOP_IP_DailyDemand SC(delayStart=0,W_nominal_BOP= 1.710e08,Wind_Power=windPlant_MultiInstantiate_Day.WindPower)
        annotation (Placement(transformation(extent={{138,42},{192,92}})));
    equation
      connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-58,60.6},
              {-50,60.6},{-50,81.3333},{-38,81.3333}},
                                                  color={0,127,255}));
      connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-58,16.6},{-52,
              16.6},{-52,16},{-44,16},{-44,82},{-38,82}},
                                        color={0,127,255}));
      connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-56,-28},
              {-42,-28},{-42,82.6667},{-38,82.6667}},
                                                   color={0,127,255}));
      connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-26,82},{-20,82},
              {-20,26.6},{-8,26.6}},  color={0,127,255}));
      connect(EM.port_b1, volume1.port_a[1]) annotation (Line(points={{-8,11.4},{-16,
              11.4},{-16,-58},{-24,-58}},color={0,127,255}));
      connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-58,45.4},
              {-48,45.4},{-48,-58.6667},{-36,-58.6667}},
                                                    color={0,127,255}));
      connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-58,1.4},{-46,
              1.4},{-46,-58},{-36,-58}}, color={0,127,255}));
      connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-56,-44},
              {-44,-44},{-44,-57.3333},{-36,-57.3333}},  color={0,127,255}));
      connect(EM.port_b2, BOP.port_a) annotation (Line(points={{28,26.6},{34,26.6},{
              34,25.2},{42,25.2}}, color={0,127,255}));
      connect(EM.port_a2, BOP.port_b) annotation (Line(points={{28,11.4},{34,11.4},{
              34,10.8},{42,10.8}},
                              color={0,127,255}));
      connect(BOP.portElec_b, SY.port_a[1])
        annotation (Line(points={{78,18},{98,18},{98,18.8},{110,18.8}},
                                                   color={255,0,0}));
      connect(EM.port_b3[1], IP.port_a) annotation (Line(points={{17.2,0},{16,0},{16,
              -24},{62,-24}},    color={0,127,255}));
      connect(BOP.port_a3[1], IP.port_b) annotation (Line(points={{52.8,0},{52.8,-40},
              {62,-40}},          color={0,127,255}));
      connect(SY.port_Grid, EG.portElec_a) annotation (Line(points={{148,20},{158,20},
              {158,21},{162,21}}, color={255,0,0}));
      connect(IP.portElec_a, SY.port_a[2]) annotation (Line(points={{104,-32},{104,20},
              {110,20}},              color={255,0,0}));
      connect(windPlant_MultiInstantiate_Day.WindPower, wind_connector_Transform.powerGeneration)
        annotation (Line(points={{77.6667,66.58},{77.7778,66.58},{77.7778,66.2},
              {82,66.2}},
                      color={0,0,127}));
      connect(wind_connector_Transform.portElec_a, SY.port_a[3]) annotation (Line(
            points={{102,66},{106,66},{106,21.2},{110,21.2}}, color={255,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {200,100}})),                                        Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})),
        experiment(
          StopTime=1800,
          Interval=0.001,
          __Dymola_Algorithm="Esdirk23a"));
    end Test_NuclearWind_BOP_HTSE_Dailydemand;
  end WindGeneratn_HydrogenElectricity;

  package SolarGeneratn_ElectricityProd
    model Test_NuclearSolar_BOP_stepdemand

     parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
     parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
     parameter Integer no_modules=3;
     //parameter Real eff=0.35;

      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-96,32},{-58,70}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-96,-20},{-58,18}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-96,-68},{-56,-28}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        nPorts_b=1,
        p_start=PHS.port_b_nominal.p,
        h_start=PHS.port_b_nominal.h,
        nPorts_a=3,
        showName=false)
        annotation (Placement(transformation(extent={{-42,70},{-22,90}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        nPorts_a=1,
        p_start=PHS.port_a_nominal.p,
        h_start=PHS.port_a_nominal.h,
        nPorts_b=3,
        showName=false)
        annotation (Placement(transformation(extent={{-20,-72},{-40,-52}})));
      NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
        port_a_nominal(
          p=EM.port_b2_nominal.p,
          h=EM.port_b2_nominal.h,
          m_flow=-EM.port_b2_nominal.m_flow),
        port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h), redeclare
          NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
          CS(
          p_nominal=BOP.port_a_nominal.p,
          W_totalSetpoint=SC.W_totalSetpoint_BOP,
          delayStartTCV=0))
        annotation (Placement(transformation(extent={{42,-4},{78,32}})));
       NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=2)                                     annotation (Placement(transformation(extent={{98,-4},
                {136,32}})));
       NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{152,-2},
                {190,32}})));
       NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_boundaries
        EM(port_a1_nominal(
          p=PHS.port_b_nominal.p,
          h=PHS.port_b_nominal.h,
          m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
          port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h))
        annotation (Placement(transformation(extent={{-12,-6},{24,32}})));

      Modelica.Blocks.Sources.Step Demand(
        height=25e06,
        offset=125e06,
        startTime=3000)
        annotation (Placement(transformation(extent={{156,-64},{182,-38}})));
      Components.SupervisoryControls.Solar_BOP_StepDemand SC(delayStart=0, W_nominal_BOP= 1.710e08,
       Elec_Demand=Demand.y, Solar_Power=solarPlant_MultiInstantiate_hours.SolarPower)
        annotation (Placement(transformation(extent={{140,42},{192,90}})));
      Components.WindPlant.Wind_connector_Transform wind_connector_Transform
        annotation (Placement(transformation(extent={{56,36},{78,80}})));
      Components.SolarPlant.SolarPlant_MultiInstantiate_hours
        solarPlant_MultiInstantiate_hours
        annotation (Placement(transformation(extent={{14,52},{42,78}})));
    equation
      connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-58,58.6},
              {-50,58.6},{-50,79.3333},{-38,79.3333}},
                                                  color={0,127,255}));
      connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-58,6.6},
              {-46,6.6},{-46,80},{-38,80}},
                                        color={0,127,255}));
      connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-56,-40},
              {-42,-40},{-42,80.6667},{-38,80.6667}},
                                                   color={0,127,255}));
      connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-26,80},{-20,80},
              {-20,20.6},{-12,20.6}}, color={0,127,255}));
      connect(EM.port_b1, volume1.port_a[1]) annotation (Line(points={{-12,5.4},{-16,
              5.4},{-16,-62},{-24,-62}}, color={0,127,255}));
      connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-58,43.4},
              {-48,43.4},{-48,-62.6667},{-36,-62.6667}},
                                                    color={0,127,255}));
      connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-58,
              -8.6},{-46,-8.6},{-46,-62},{-36,-62}},
                                         color={0,127,255}));
      connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-56,-56},
              {-44,-56},{-44,-61.3333},{-36,-61.3333}},  color={0,127,255}));
      connect(EM.port_b2, BOP.port_a) annotation (Line(points={{24,20.6},{34,20.6},{
              34,21.2},{42,21.2}}, color={0,127,255}));
      connect(EM.port_a2, BOP.port_b) annotation (Line(points={{24,5.4},{34,5.4},{34,
              6.8},{42,6.8}}, color={0,127,255}));
      connect(BOP.portElec_b, SY.port_a[1])
        annotation (Line(points={{78,14},{88,14},{88,13.1},{98,13.1}},
                                                   color={255,0,0}));
      connect(SY.port_Grid, EG.portElec_a) annotation (Line(points={{136,14},{146,14},
              {146,15},{152,15}}, color={255,0,0}));
      connect(wind_connector_Transform.portElec_a, SY.port_a[2]) annotation (Line(
            points={{78,62.4},{88,62.4},{88,14.9},{98,14.9}}, color={255,0,0}));
      connect(wind_connector_Transform.powerGeneration,
        solarPlant_MultiInstantiate_hours.SolarPower) annotation (Line(points={{56,
              62.84},{54,62.84},{54,62.6889},{43.4,62.6889}},
                                                       color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {200,100}})),                                        Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})),
        experiment(
          StopTime=5000,
          Interval=60,
          __Dymola_Algorithm="Esdirk23a"));
    end Test_NuclearSolar_BOP_stepdemand;

  end SolarGeneratn_ElectricityProd;

  package SolarGeneratn_HydrogenElectricity
    model Test_NuclearSolar_BOP_HTSE_stepdemand

     parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
     parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
     parameter Integer no_modules=3;
    // parameter Real eff=0.35;

      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-96,34},{-58,72}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-96,-10},{-58,28}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-96,-56},{-56,-16}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        nPorts_b=1,
        p_start=PHS.port_b_nominal.p,
        h_start=PHS.port_b_nominal.h,
        nPorts_a=3,
        showName=false)
        annotation (Placement(transformation(extent={{-42,72},{-22,92}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        nPorts_a=1,
        p_start=PHS.port_a_nominal.p,
        h_start=PHS.port_a_nominal.h,
        nPorts_b=3,
        showName=false)
        annotation (Placement(transformation(extent={{-20,-68},{-40,-48}})));
      NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
        port_a_nominal(
          p=EM.port_b2_nominal.p,
          h=EM.port_b2_nominal.h,
          m_flow=-EM.port_b2_nominal.m_flow),
        port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h), redeclare
          NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
          CS(
          p_nominal=BOP.port_a_nominal.p,
          W_totalSetpoint=SC.W_totalSetpoint_BOP,
          delayStartTCV=0), nPorts_a3=1)
        annotation (Placement(transformation(extent={{42,0},{78,36}})));
       NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=3)                                     annotation (Placement(transformation(extent={{110,2},
                {148,38}})));
       NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{162,4},
                {200,38}})));
       NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_boundaries
        EM(port_a1_nominal(
          p=PHS.port_b_nominal.p,
          h=PHS.port_b_nominal.h,
          m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
          port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
        nPorts_b3=1)
        annotation (Placement(transformation(extent={{-8,0},{28,38}})));

      Modelica.Blocks.Sources.Step Demand(
        height=25e06,
        offset=125e06,
        startTime=3000)
        annotation (Placement(transformation(extent={{158,-50},{178,-30}})));
      Components.HTSE.SteamControl.HTSESteamFlowCtrl_GenericModular
        IP(
        capacity=51.1454e6,
        redeclare
          Components.HTSE.SteamControl.CS_TightlyCoupled_SteamFlowCtrl_modified CS(
          capacityScaler=IP.capacityScaler,
          delayStart=10,
          W_totalSetpoint=SC.W_totalSetpoint_IP),
        port_a_nominal(m_flow=IP.capacityScaler_steamFlow*9.0942),
        hEX_nuclearHeatAnodeGasRecup_ROM(TTube_out(start=259 + 273.15, fixed=false)),
        returnPump(PR0=62.7/43.1794))
        annotation (Placement(transformation(extent={{62,-52},{104,-12}})));

      Components.WindPlant.Wind_connector_Transform wind_connector_Transform
        annotation (Placement(transformation(extent={{82,54},{102,74}})));
      Components.SupervisoryControls.Solar_BOP_IP_StepDemand SC(delayStart=0,W_nominal_BOP= 1.710e08,
       Elec_Demand=Demand.y,Solar_Power=solarPlant_MultiInstantiate_hours.SolarPower)
        annotation (Placement(transformation(extent={{138,42},{192,92}})));
      Components.SolarPlant.SolarPlant_MultiInstantiate_hours
        solarPlant_MultiInstantiate_hours
        annotation (Placement(transformation(extent={{48,56},{76,82}})));
    equation
      connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-58,60.6},
              {-50,60.6},{-50,81.3333},{-38,81.3333}},
                                                  color={0,127,255}));
      connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-58,16.6},{-52,
              16.6},{-52,16},{-44,16},{-44,82},{-38,82}},
                                        color={0,127,255}));
      connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-56,-28},
              {-42,-28},{-42,82.6667},{-38,82.6667}},
                                                   color={0,127,255}));
      connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-26,82},{-20,82},
              {-20,26.6},{-8,26.6}},  color={0,127,255}));
      connect(EM.port_b1, volume1.port_a[1]) annotation (Line(points={{-8,11.4},{-16,
              11.4},{-16,-58},{-24,-58}},color={0,127,255}));
      connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-58,45.4},
              {-48,45.4},{-48,-58.6667},{-36,-58.6667}},
                                                    color={0,127,255}));
      connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-58,1.4},{-46,
              1.4},{-46,-58},{-36,-58}}, color={0,127,255}));
      connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-56,-44},
              {-44,-44},{-44,-57.3333},{-36,-57.3333}},  color={0,127,255}));
      connect(EM.port_b2, BOP.port_a) annotation (Line(points={{28,26.6},{34,26.6},{
              34,25.2},{42,25.2}}, color={0,127,255}));
      connect(EM.port_a2, BOP.port_b) annotation (Line(points={{28,11.4},{34,11.4},{
              34,10.8},{42,10.8}},
                              color={0,127,255}));
      connect(BOP.portElec_b, SY.port_a[1])
        annotation (Line(points={{78,18},{98,18},{98,18.8},{110,18.8}},
                                                   color={255,0,0}));
      connect(EM.port_b3[1], IP.port_a) annotation (Line(points={{17.2,0},{16,0},{16,
              -24},{62,-24}},    color={0,127,255}));
      connect(BOP.port_a3[1], IP.port_b) annotation (Line(points={{52.8,0},{52.8,-40},
              {62,-40}},          color={0,127,255}));
      connect(SY.port_Grid, EG.portElec_a) annotation (Line(points={{148,20},{158,20},
              {158,21},{162,21}}, color={255,0,0}));
      connect(IP.portElec_a, SY.port_a[2]) annotation (Line(points={{104,-32},{104,20},
              {110,20}},              color={255,0,0}));
      connect(wind_connector_Transform.portElec_a, SY.port_a[3]) annotation (Line(
            points={{102,66},{106,66},{106,21.2},{110,21.2}}, color={255,0,0}));
      connect(solarPlant_MultiInstantiate_hours.SolarPower,
        wind_connector_Transform.powerGeneration) annotation (Line(points={{77.4,
              66.6889},{78.7,66.6889},{78.7,66.2},{82,66.2}},
                                                     color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {200,100}})),                                        Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})),
        experiment(
          StopTime=5000,
          Interval=60,
          __Dymola_Algorithm="Esdirk23a"));
    end Test_NuclearSolar_BOP_HTSE_stepdemand;

    model Test_NuclearSolar_BOP_HTSE_Dailydemand

     parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
     parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
     parameter Integer no_modules=3;
    // parameter Real eff=0.35;

      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-96,34},{-58,72}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-96,-10},{-58,28}})));
      NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(
          redeclare
          NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
        annotation (Placement(transformation(extent={{-96,-56},{-56,-16}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        nPorts_b=1,
        p_start=PHS.port_b_nominal.p,
        h_start=PHS.port_b_nominal.h,
        nPorts_a=3,
        showName=false)
        annotation (Placement(transformation(extent={{-42,72},{-22,92}})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.001),
        nPorts_a=1,
        p_start=PHS.port_a_nominal.p,
        h_start=PHS.port_a_nominal.h,
        nPorts_b=3,
        showName=false)
        annotation (Placement(transformation(extent={{-20,-68},{-40,-48}})));
      NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
        port_a_nominal(
          p=EM.port_b2_nominal.p,
          h=EM.port_b2_nominal.h,
          m_flow=-EM.port_b2_nominal.m_flow),
        port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h), redeclare
          NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
          CS(
          p_nominal=BOP.port_a_nominal.p,
          W_totalSetpoint=SC.W_totalSetpoint_BOP,
          delayStartTCV=0), nPorts_a3=1)
        annotation (Placement(transformation(extent={{42,0},{78,36}})));
       NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=3)                                     annotation (Placement(transformation(extent={{110,2},
                {148,38}})));
       NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{162,4},
                {200,38}})));
       NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_boundaries
        EM(port_a1_nominal(
          p=PHS.port_b_nominal.p,
          h=PHS.port_b_nominal.h,
          m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
          port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
        nPorts_b3=1)
        annotation (Placement(transformation(extent={{-8,0},{28,38}})));

      Components.HTSE.SteamControl.HTSESteamFlowCtrl_GenericModular
        IP(
        capacity=51.1454e6,
        redeclare
          Components.HTSE.SteamControl.CS_TightlyCoupled_SteamFlowCtrl_modified CS(
          capacityScaler=IP.capacityScaler,
          delayStart=10,
          W_totalSetpoint=SC.W_totalSetpoint_IP),
        port_a_nominal(m_flow=IP.capacityScaler_steamFlow*9.0942),
        hEX_nuclearHeatAnodeGasRecup_ROM(TTube_out(start=259 + 273.15, fixed=false)),
        returnPump(PR0=62.7/43.1794))
        annotation (Placement(transformation(extent={{62,-52},{104,-12}})));

      Components.WindPlant.Wind_connector_Transform wind_connector_Transform
        annotation (Placement(transformation(extent={{82,54},{102,74}})));
      Components.SupervisoryControls.Solar_BOP_IP_DailyDemand SC(delayStart=0,W_nominal_BOP= 1.710e08,
       Solar_Power=solarPlant_MultiInstantiate_Day.SolarPower)
        annotation (Placement(transformation(extent={{138,42},{192,92}})));
      Journal_IES_Simulations.Components.SolarPlant.SolarPlant_MultiInstantiate_Day
        solarPlant_MultiInstantiate_Day
        annotation (Placement(transformation(extent={{48,56},{76,82}})));
    equation
      connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-58,60.6},
              {-50,60.6},{-50,81.3333},{-38,81.3333}},
                                                  color={0,127,255}));
      connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-58,16.6},{-52,
              16.6},{-52,16},{-44,16},{-44,82},{-38,82}},
                                        color={0,127,255}));
      connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-56,-28},
              {-42,-28},{-42,82.6667},{-38,82.6667}},
                                                   color={0,127,255}));
      connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-26,82},{-20,82},
              {-20,26.6},{-8,26.6}},  color={0,127,255}));
      connect(EM.port_b1, volume1.port_a[1]) annotation (Line(points={{-8,11.4},{-16,
              11.4},{-16,-58},{-24,-58}},color={0,127,255}));
      connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-58,45.4},
              {-48,45.4},{-48,-58.6667},{-36,-58.6667}},
                                                    color={0,127,255}));
      connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-58,1.4},{-46,
              1.4},{-46,-58},{-36,-58}}, color={0,127,255}));
      connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-56,-44},
              {-44,-44},{-44,-57.3333},{-36,-57.3333}},  color={0,127,255}));
      connect(EM.port_b2, BOP.port_a) annotation (Line(points={{28,26.6},{34,26.6},{
              34,25.2},{42,25.2}}, color={0,127,255}));
      connect(EM.port_a2, BOP.port_b) annotation (Line(points={{28,11.4},{34,11.4},{
              34,10.8},{42,10.8}},
                              color={0,127,255}));
      connect(BOP.portElec_b, SY.port_a[1])
        annotation (Line(points={{78,18},{98,18},{98,18.8},{110,18.8}},
                                                   color={255,0,0}));
      connect(EM.port_b3[1], IP.port_a) annotation (Line(points={{17.2,0},{16,0},{16,
              -24},{62,-24}},    color={0,127,255}));
      connect(BOP.port_a3[1], IP.port_b) annotation (Line(points={{52.8,0},{52.8,-40},
              {62,-40}},          color={0,127,255}));
      connect(SY.port_Grid, EG.portElec_a) annotation (Line(points={{148,20},{158,20},
              {158,21},{162,21}}, color={255,0,0}));
      connect(IP.portElec_a, SY.port_a[2]) annotation (Line(points={{104,-32},{104,20},
              {110,20}},              color={255,0,0}));
      connect(wind_connector_Transform.portElec_a, SY.port_a[3]) annotation (Line(
            points={{102,66},{106,66},{106,21.2},{110,21.2}}, color={255,0,0}));
      connect(solarPlant_MultiInstantiate_Day.SolarPower,
        wind_connector_Transform.powerGeneration) annotation (Line(points={{77.4,
              66.6889},{78.7,66.6889},{78.7,66.2},{82,66.2}},
                                                     color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {200,100}})),                                        Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})),
        experiment(
          StopTime=86400,
          Interval=60,
          __Dymola_Algorithm="Esdirk23a"));
    end Test_NuclearSolar_BOP_HTSE_Dailydemand;

    model Test
      Components.SolarPlant.SolarPlant_MultiInstantiate_Day
        solarPlant_MultiInstantiate_Day
        annotation (Placement(transformation(extent={{-90,-10},{-28,46}})));
      Components.SupervisoryControls.Solar_BOP_IP_DailyDemand SC(Solar_Power=solarPlant_MultiInstantiate_Day.SolarPower)
        annotation (Placement(transformation(extent={{-18,-40},{66,40}})));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Test;
  end SolarGeneratn_HydrogenElectricity;

  package HILExperiments
    package WindTest
      model Test_NuclearWind_BOP_HTSE_7200_NoDisrup

       parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
       parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
       parameter Integer no_modules=3;
      // parameter Real eff=0.35;

        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-96,34},{-58,72}})));
        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-96,-10},{-58,28}})));
        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-96,-56},{-56,-16}})));
        TRANSFORM.Fluid.Volumes.MixingVolume volume(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          use_T_start=false,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
              (V=0.001),
          nPorts_b=1,
          p_start=PHS.port_b_nominal.p,
          h_start=PHS.port_b_nominal.h,
          nPorts_a=3,
          showName=false)
          annotation (Placement(transformation(extent={{-42,72},{-22,92}})));
        TRANSFORM.Fluid.Volumes.MixingVolume volume1(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          use_T_start=false,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
              (V=0.001),
          nPorts_a=1,
          p_start=PHS.port_a_nominal.p,
          h_start=PHS.port_a_nominal.h,
          nPorts_b=3,
          showName=false)
          annotation (Placement(transformation(extent={{-20,-68},{-40,-48}})));
        NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
          port_a_nominal(
            p=EM.port_b2_nominal.p,
            h=EM.port_b2_nominal.h,
            m_flow=-EM.port_b2_nominal.m_flow),
          port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h), redeclare
            NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
            CS(
            p_nominal=BOP.port_a_nominal.p,
            W_totalSetpoint=SC.W_totalSetpoint_BOP,
            delayStartTCV=0), nPorts_a3=1)
          annotation (Placement(transformation(extent={{42,0},{78,36}})));
         NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=3)                                     annotation (Placement(transformation(extent={{110,2},
                  {148,38}})));
         NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{162,4},
                  {200,38}})));
         NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_boundaries
          EM(port_a1_nominal(
            p=PHS.port_b_nominal.p,
            h=PHS.port_b_nominal.h,
            m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
            port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
          nPorts_b3=1)
          annotation (Placement(transformation(extent={{-8,0},{28,38}})));

        Components.HTSE.SteamControl.HTSESteamFlowCtrl_GenericModular
          IP(
          capacity=51.1454e6,
          redeclare
            Components.HTSE.SteamControl.CS_TightlyCoupled_SteamFlowCtrl_modified CS(
            capacityScaler=IP.capacityScaler,
            delayStart=10,
            W_totalSetpoint=SC.W_totalSetpoint_IP),
          port_a_nominal(m_flow=IP.capacityScaler_steamFlow*9.0942),
          hEX_nuclearHeatAnodeGasRecup_ROM(TTube_out(start=259 + 273.15, fixed=false)),
          returnPump(PR0=62.7/43.1794))
          annotation (Placement(transformation(extent={{62,-52},{104,-12}})));

        WindPlant_MultiInstantiate windPlant_MultiInstantiate_Day
          annotation (Placement(transformation(extent={{12,54},{42,88}})));
        Components.WindPlant.Wind_connector_Transform wind_connector_Transform
          annotation (Placement(transformation(extent={{82,54},{102,74}})));
        Wind_BOP_IP_Demand SC(
          delayStart=500,
          W_nominal_BOP=1.710e08,
          Wind_Power=SY.port_a[3].W)
          annotation (Placement(transformation(extent={{138,42},{192,92}})));

      equation
        connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-58,
                60.6},{-50,60.6},{-50,81.3333},{-38,81.3333}},
                                                    color={0,127,255}));
        connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-58,16.6},{-52,
                16.6},{-52,16},{-44,16},{-44,82},{-38,82}},
                                          color={0,127,255}));
        connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-56,-28},
                {-42,-28},{-42,82.6667},{-38,82.6667}},
                                                     color={0,127,255}));
        connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-26,82},{-20,82},
                {-20,26.6},{-8,26.6}},  color={0,127,255}));
        connect(EM.port_b1, volume1.port_a[1]) annotation (Line(points={{-8,11.4},{-16,
                11.4},{-16,-58},{-24,-58}},color={0,127,255}));
        connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-58,
                45.4},{-48,45.4},{-48,-58.6667},{-36,-58.6667}},
                                                      color={0,127,255}));
        connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-58,1.4},{-46,
                1.4},{-46,-58},{-36,-58}}, color={0,127,255}));
        connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-56,-44},
                {-44,-44},{-44,-57.3333},{-36,-57.3333}},  color={0,127,255}));
        connect(EM.port_b2, BOP.port_a) annotation (Line(points={{28,26.6},{34,26.6},{
                34,25.2},{42,25.2}}, color={0,127,255}));
        connect(EM.port_a2, BOP.port_b) annotation (Line(points={{28,11.4},{34,11.4},{
                34,10.8},{42,10.8}},
                                color={0,127,255}));
        connect(BOP.portElec_b, SY.port_a[1])
          annotation (Line(points={{78,18},{98,18},{98,18.8},{110,18.8}},
                                                     color={255,0,0}));
        connect(EM.port_b3[1], IP.port_a) annotation (Line(points={{17.2,0},{16,0},{16,
                -24},{62,-24}},    color={0,127,255}));
        connect(BOP.port_a3[1], IP.port_b) annotation (Line(points={{52.8,0},{52.8,-40},
                {62,-40}},          color={0,127,255}));
        connect(SY.port_Grid, EG.portElec_a) annotation (Line(points={{148,20},{158,20},
                {158,21},{162,21}}, color={255,0,0}));
        connect(IP.portElec_a, SY.port_a[2]) annotation (Line(points={{104,-32},{104,20},
                {110,20}},              color={255,0,0}));
        connect(windPlant_MultiInstantiate_Day.WindPower, wind_connector_Transform.powerGeneration)
          annotation (Line(points={{43.6667,66.58},{77.7778,66.58},{77.7778,
                66.2},{82,66.2}},
                        color={0,0,127}));
        connect(wind_connector_Transform.portElec_a, SY.port_a[3]) annotation (Line(
              points={{102,66},{106,66},{106,21.2},{110,21.2}}, color={255,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {200,100}})),                                        Diagram(
              coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})),
          experiment(
            StopTime=3600,
            Interval=60,
            __Dymola_Algorithm="Esdirk23a"));
      end Test_NuclearWind_BOP_HTSE_7200_NoDisrup;

      model WindPlant_MultiInstantiate
          extends
          NHES.Systems.Templates.SubSystem_Standalone.BaseClasses.Partial_SubSystem_A(
          redeclare replaceable
            NHES.Systems.Templates.SubSystem_Standalone.CS.CS_Dummy CS,
          redeclare replaceable
            NHES.Systems.Templates.SubSystem_Standalone.CS.ED_Dummy ED,
          redeclare NHES.Systems.Templates.SubSystem_Standalone.Data.Data_Dummy
            data);

       parameter Integer no_units=17;

        Modelica.Blocks.Math.MultiSum AggregatedWindPower(k=fill(-1, no_units), nu=
              no_units)
          annotation (Placement(transformation(extent={{-8,22},{14,44}})));

        WindModel wind_unit[no_units]
          annotation (Placement(transformation(extent={{-78,18},{-56,40}})));

        Modelica.Blocks.Interfaces.RealOutput WindPower
          annotation (Placement(transformation(extent={{100,24},{120,44}})));
      equation
        for i in 1:no_units loop
          connect(wind_unit[i].plant.power, AggregatedWindPower.u[i]);
        end for;

        connect(AggregatedWindPower.y, WindPower) annotation (Line(points={{15.87,33},
                {57.935,33},{57.935,34},{110,34}}, color={0,0,127}));
       annotation(experiment(
            StopTime=1800,
            Interval=0.1,
            __Dymola_Algorithm="Dassl"),
          Diagram(coordinateSystem(extent={{-80,-40},{100,160}})),
          Icon(coordinateSystem(extent={{-80,-40},{100,160}})));
      end WindPlant_MultiInstantiate;

      model WindModel "Generic wind power plant simulation with real wind data"
        extends Modelica.Icons.Example;
        parameter String fileName = Modelica.Utilities.Files.loadResource("C:/Users/raj180002/OneDrive - The University of Texas at Dallas/Dymola/Library/AA My packages/WindPowerPlants/Resources/Data/beresford2006.txt") "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
        WindPowerPlants.Plants.GenericVariableSpeed plant(limitMot = 0.01, k = 120 * 112.8) annotation(Placement(transformation(extent = {{10, -10}, {30, 10}})));
        WindPowerPlants.WindSources.RealData windSource(fileName=fileName)
          annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
        WindPowerPlants.Blocks.SpeedAdaptor speedadaptor1(hin = 50, hout = 105, roughness = 0.1) annotation(Placement(transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}})));
        Modelica.Blocks.Interfaces.RealOutput Power
          annotation (Placement(transformation(extent={{96,8},{116,28}})));
      equation
        connect(windSource.v, speedadaptor1.vin) annotation(Line(points={{-27,0},{-22,
                0}},                                                                                        color = {0, 0, 127}));
        connect(speedadaptor1.vout, plant.v) annotation(Line(points = {{1, 0}, {4, 0}, {4, 8.88178e-16}, {8, 8.88178e-16}}, color = {0, 0, 127}));
        connect(plant.power, Power)
          annotation (Line(points={{26,11},{26,18},{106,18}}, color={0,0,127}));
        annotation(experiment(
            StopTime=7200,
            Interval=0.1,
            __Dymola_Algorithm="Dassl"));
      end WindModel;

      model Wind_BOP_IP_Demand
        extends
          NHES.Systems.SupervisoryControl.BaseClasses.Partial_ControlSystem;

        parameter Real delayStart=500 "Time to start tracking power profiles";
        parameter Modelica.Units.SI.Time timeScale=1800
          "Time scale of first table column";

        parameter Modelica.Units.SI.Power W_nominal_BOP=4.13285e8 "Nominal BOP Power";

        parameter Modelica.Units.SI.Power W_IP_nom(displayUnit="MW")=51.1454e6
          "Nominal electrical power consumption in the IP";
        final parameter Modelica.Units.SI.Power W_IP_max(displayUnit="MW")=
          W_IP_nom "Maximum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power W_IP_min(displayUnit="MW")=20.9561e6
          "Minimum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power HTSE_Q=18.5;
        parameter Real HTSE_eff=0.35;

        input Modelica.Units.SI.Power Wind_Power "Wind power";

        output Modelica.Units.SI.Power W_totalSetpoint_BOP=switch_BOP.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_EG=switch_EG.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_IP=switch_IP.y
          annotation (Dialog(group="Outputs", enable=false));
        parameter String fileName=Modelica.Utilities.Files.loadResource(
            "C:/Users/raj180002/OneDrive - The University of Texas at Dallas/Dymola/Journal_NHES_Data/HIL Data/Demand_Alter.txt")
          "File where matrix is stored";

        Modelica.Blocks.Logical.LessThreshold greaterEqualThreshold1(threshold=
              delayStart)
          annotation (Placement(transformation(extent={{-112,18},{-92,38}})));
        Modelica.Blocks.Logical.Switch switch_BOP
          annotation (Placement(transformation(extent={{2,108},{22,128}})));
        Modelica.Blocks.Sources.Constant BOP_nominal(k=1.71e08)
          annotation (Placement(transformation(extent={{-44,132},{-24,152}})));

        Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
          annotation (Placement(transformation(extent={{-160,18},{-140,38}})));

        Modelica.Blocks.Logical.Switch switch_EG
          annotation (Placement(transformation(extent={{44,18},{64,38}})));
        Modelica.Blocks.Logical.Switch switch_IP
          annotation (Placement(transformation(extent={{48,-78},{68,-58}})));
        Modelica.Blocks.Sources.Constant HTSE_nominal(k=51e06)
          annotation (Placement(transformation(extent={{-36,-54},{-16,-34}})));
        Modelica.Blocks.Sources.RealExpression IPDemand(y=BOP_nominal.y + Wind_Power -
              HTSE_Q*HTSE_eff - GridDemand.y)
          annotation (Placement(transformation(extent={{-72,-120},{-52,-100}})));
        Modelica.Blocks.Sources.RealExpression BOPDemand(y=GridDemand.y +
              limiter_HTSE_W.y - Wind_Power)
          annotation (Placement(transformation(extent={{-46,94},{-26,114}})));
        Modelica.Blocks.Nonlinear.Limiter limiter_HTSE_W(uMax=W_IP_max, uMin=W_IP_min)
          annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={-12,-94})));
        Modelica.Blocks.Sources.RealExpression Grid_nominal(y=BOP_nominal.y -
              HTSE_nominal.y)
          annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
        Modelica.Blocks.Sources.CombiTimeTable demand_EG(
          tableOnFile=true,
          timeScale=1,
          startTime=delayStart,
          tableName="Grid",
          fileName=fileName)
          annotation (Placement(transformation(extent={{-54,-6},{-34,14}})));
        Modelica.Blocks.Math.Gain GridDemand(k=1.71e08)
          annotation (Placement(transformation(extent={{-16,-6},{4,14}})));
      equation
        connect(BOP_nominal.y, switch_BOP.u1) annotation (Line(points={{-23,142},{-6,142},
                {-6,126},{0,126}},         color={0,0,127}));
        connect(clock.y, greaterEqualThreshold1.u)
          annotation (Line(points={{-139,28},{-114,28}},           color={0,0,127}));
        connect(greaterEqualThreshold1.y, switch_BOP.u2) annotation (Line(points={{-91,28},
                {-72,28},{-72,118},{0,118}},     color={255,0,255}));
        connect(switch_EG.u2, switch_BOP.u2) annotation (Line(points={{42,28},{-72,28},
                {-72,118},{0,118}},                    color={255,0,255}));
        connect(switch_IP.u2, switch_BOP.u2) annotation (Line(points={{46,-68},{-72,-68},
                {-72,118},{0,118}}, color={255,0,255}));
        connect(HTSE_nominal.y, switch_IP.u1) annotation (Line(points={{-15,-44},{30,-44},
                {30,-60},{46,-60}}, color={0,0,127}));
        connect(BOPDemand.y, switch_BOP.u3) annotation (Line(points={{-25,104},{-10,104},
                {-10,110},{0,110}}, color={0,0,127}));
        connect(IPDemand.y, limiter_HTSE_W.u)
          annotation (Line(points={{-51,-110},{-42,-110},{-42,-94},{-24,-94}},
                                                         color={0,0,127}));
        connect(limiter_HTSE_W.y, switch_IP.u3) annotation (Line(points={{-1,-94},
                {30,-94},{30,-76},{46,-76}},
                                         color={0,0,127}));
        connect(Grid_nominal.y, switch_EG.u1) annotation (Line(points={{-25,60},{14,60},
                {14,36},{42,36}}, color={0,0,127}));
        connect(demand_EG.y[1], GridDemand.u)
          annotation (Line(points={{-33,4},{-18,4}}, color={0,0,127}));
        connect(GridDemand.y, switch_EG.u3)
          annotation (Line(points={{5,4},{24,4},{24,20},{42,20}}, color={0,0,127}));
      annotation(defaultComponentName="SC", experiment(
            StopTime=7200,
            Interval=60,
            __Dymola_Algorithm="Dassl"),
          Diagram(coordinateSystem(extent={{-180,-160},{160,160}})),
          Icon(coordinateSystem(extent={{-180,-160},{160,160}}), graphics={
                        Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Input Setpoints: Modelica Path")}));
      end Wind_BOP_IP_Demand;

      model SCTest
        extends NHES.Systems.SupervisoryControl.BaseClasses.Partial_ControlSystem;

        parameter Real delayStart=500 "Time to start tracking power profiles";
        parameter Modelica.Units.SI.Time timeScale=1800
          "Time scale of first table column";

        parameter Modelica.Units.SI.Power W_nominal_BOP=4.13285e8 "Nominal BOP Power";

        parameter Modelica.Units.SI.Power W_IP_nom(displayUnit="MW")=51.1454e6
          "Nominal electrical power consumption in the IP";
        final parameter Modelica.Units.SI.Power W_IP_max(displayUnit="MW")=
          W_IP_nom "Maximum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power W_IP_min(displayUnit="MW")=20.9561e6
          "Minimum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power HTSE_Q=18.5;
        parameter Real HTSE_eff=0.35;

        input Modelica.Units.SI.Power Wind_Power "Wind power";

        output Modelica.Units.SI.Power W_totalSetpoint_BOP=switch_BOP.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_EG=switch_EG.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_IP=switch_IP.y
          annotation (Dialog(group="Outputs", enable=false));
        parameter String fileName=Modelica.Utilities.Files.loadResource(
            "C:/Users/raj180002/OneDrive - The University of Texas at Dallas/Dymola/Journal_NHES_Data/HIL Data/Demand_Alter.txt")
          "File where matrix is stored";

        Modelica.Blocks.Logical.LessThreshold greaterEqualThreshold1(threshold=
              delayStart)
          annotation (Placement(transformation(extent={{-112,18},{-92,38}})));
        Modelica.Blocks.Logical.Switch switch_BOP
          annotation (Placement(transformation(extent={{2,108},{22,128}})));
        Modelica.Blocks.Sources.Constant BOP_nominal(k=1.71e08)
          annotation (Placement(transformation(extent={{-44,132},{-24,152}})));

        Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
          annotation (Placement(transformation(extent={{-160,18},{-140,38}})));

        Modelica.Blocks.Logical.Switch switch_EG
          annotation (Placement(transformation(extent={{44,18},{64,38}})));
        Modelica.Blocks.Logical.Switch switch_IP
          annotation (Placement(transformation(extent={{48,-78},{68,-58}})));
        Modelica.Blocks.Sources.Constant HTSE_nominal(k=51e06)
          annotation (Placement(transformation(extent={{-36,-54},{-16,-34}})));
        Modelica.Blocks.Sources.RealExpression IPDemand(y=BOP_nominal.y + Wind_Power -
              HTSE_Q*HTSE_eff - GridDemand.y)
          annotation (Placement(transformation(extent={{-72,-120},{-52,-100}})));
        Modelica.Blocks.Sources.RealExpression BOPDemand(y=GridDemand.y +
              limiter_HTSE_W.y - WindPlant.WindPower)
          annotation (Placement(transformation(extent={{-46,94},{-26,114}})));
        Modelica.Blocks.Nonlinear.Limiter limiter_HTSE_W(uMax=W_IP_max, uMin=W_IP_min)
          annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={-12,-94})));
        Modelica.Blocks.Sources.RealExpression Grid_nominal(y=BOP_nominal.y -
              HTSE_nominal.y)
          annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
        Modelica.Blocks.Sources.CombiTimeTable demand_EG(
          tableOnFile=true,
          timeScale=1,
          startTime=delayStart,
          tableName="Grid",
          fileName=fileName,
          shiftTime=0)
          annotation (Placement(transformation(extent={{-54,-6},{-34,14}})));
        Modelica.Blocks.Math.Gain GridDemand(k=1.71e08)
          annotation (Placement(transformation(extent={{-16,-6},{4,14}})));
        WindPlant_MultiInstantiate WindPlant
          annotation (Placement(transformation(extent={{-162,84},{-136,112}})));
      equation
        connect(BOP_nominal.y, switch_BOP.u1) annotation (Line(points={{-23,142},{-6,142},
                {-6,126},{0,126}},         color={0,0,127}));
        connect(clock.y, greaterEqualThreshold1.u)
          annotation (Line(points={{-139,28},{-114,28}},           color={0,0,127}));
        connect(greaterEqualThreshold1.y, switch_BOP.u2) annotation (Line(points={{-91,28},
                {-72,28},{-72,118},{0,118}},     color={255,0,255}));
        connect(switch_EG.u2, switch_BOP.u2) annotation (Line(points={{42,28},{-72,28},
                {-72,118},{0,118}},                    color={255,0,255}));
        connect(switch_IP.u2, switch_BOP.u2) annotation (Line(points={{46,-68},{-72,-68},
                {-72,118},{0,118}}, color={255,0,255}));
        connect(HTSE_nominal.y, switch_IP.u1) annotation (Line(points={{-15,-44},{30,-44},
                {30,-60},{46,-60}}, color={0,0,127}));
        connect(BOPDemand.y, switch_BOP.u3) annotation (Line(points={{-25,104},{-10,104},
                {-10,110},{0,110}}, color={0,0,127}));
        connect(IPDemand.y, limiter_HTSE_W.u)
          annotation (Line(points={{-51,-110},{-42,-110},{-42,-94},{-24,-94}},
                                                         color={0,0,127}));
        connect(limiter_HTSE_W.y, switch_IP.u3) annotation (Line(points={{-1,-94},
                {30,-94},{30,-76},{46,-76}},
                                         color={0,0,127}));
        connect(Grid_nominal.y, switch_EG.u1) annotation (Line(points={{-25,60},{14,60},
                {14,36},{42,36}}, color={0,0,127}));
        connect(demand_EG.y[1], GridDemand.u)
          annotation (Line(points={{-33,4},{-18,4}}, color={0,0,127}));
        connect(GridDemand.y, switch_EG.u3)
          annotation (Line(points={{5,4},{24,4},{24,20},{42,20}}, color={0,0,127}));
      annotation(defaultComponentName="SC", experiment(
            StopTime=7200,
            Interval=60,
            __Dymola_Algorithm="Esdirk23a"),
          Diagram(coordinateSystem(extent={{-180,-160},{160,160}})),
          Icon(coordinateSystem(extent={{-180,-160},{160,160}}), graphics={
                        Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Input Setpoints: Modelica Path")}));
      end SCTest;

      model Test_NuclearWind_BOP_HTSE_7200_WDisrup

       parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
       parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
       parameter Integer no_modules=3;
      // parameter Real eff=0.35;

        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-96,34},{-58,72}})));
        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-96,-10},{-58,28}})));
        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-96,-56},{-56,-16}})));
        TRANSFORM.Fluid.Volumes.MixingVolume volume(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          use_T_start=false,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
              (V=0.001),
          nPorts_b=1,
          p_start=PHS.port_b_nominal.p,
          h_start=PHS.port_b_nominal.h,
          nPorts_a=3,
          showName=false)
          annotation (Placement(transformation(extent={{-42,72},{-22,92}})));
        TRANSFORM.Fluid.Volumes.MixingVolume volume1(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          use_T_start=false,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
              (V=0.001),
          nPorts_a=1,
          p_start=PHS.port_a_nominal.p,
          h_start=PHS.port_a_nominal.h,
          nPorts_b=3,
          showName=false)
          annotation (Placement(transformation(extent={{-20,-68},{-40,-48}})));
        NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
          port_a_nominal(
            p=EM.port_b2_nominal.p,
            h=EM.port_b2_nominal.h,
            m_flow=-EM.port_b2_nominal.m_flow),
          port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h), redeclare
            NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
            CS(
            p_nominal=BOP.port_a_nominal.p,
            W_totalSetpoint=SC.W_totalSetpoint_BOP,
            delayStartTCV=0), nPorts_a3=1)
          annotation (Placement(transformation(extent={{42,0},{78,36}})));
         NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=3)                                     annotation (Placement(transformation(extent={{110,2},
                  {148,38}})));
         NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{162,4},
                  {200,38}})));
         NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_boundaries
          EM(port_a1_nominal(
            p=PHS.port_b_nominal.p,
            h=PHS.port_b_nominal.h,
            m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
            port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
          nPorts_b3=1)
          annotation (Placement(transformation(extent={{-8,0},{28,38}})));

        Components.HTSE.SteamControl.HTSESteamFlowCtrl_GenericModular
          IP(
          capacity=51.1454e6,
          redeclare
            Components.HTSE.SteamControl.CS_TightlyCoupled_SteamFlowCtrl_modified CS(
            capacityScaler=IP.capacityScaler,
            delayStart=10,
            W_totalSetpoint=SC.W_totalSetpoint_IP),
          port_a_nominal(m_flow=IP.capacityScaler_steamFlow*9.0942),
          hEX_nuclearHeatAnodeGasRecup_ROM(TTube_out(start=259 + 273.15, fixed=false)),
          returnPump(PR0=62.7/43.1794))
          annotation (Placement(transformation(extent={{62,-52},{104,-12}})));

        WindPlant_MultiInstantiate windPlant_MultiInstantiate_Day
          annotation (Placement(transformation(extent={{4,56},{34,90}})));
        Components.WindPlant.Wind_connector_Transform wind_connector_Transform
          annotation (Placement(transformation(extent={{56,50},{80,82}})));
        Wind_BOP_IP_Demand SC(
          delayStart=500,
          W_nominal_BOP=1.710e08,
          Wind_Power=SY.port_a[3].W)
          annotation (Placement(transformation(extent={{138,42},{192,92}})));

        NHES.Electrical.Breaker breaker
          annotation (Placement(transformation(extent={{88,56},{102,70}})));
        Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
          annotation (Placement(transformation(extent={{-6,-6},{6,6}},
              rotation=180,
              origin={136,78})));
        Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=
             3600) annotation (Placement(transformation(
              extent={{-6,-6},{6,6}},
              rotation=180,
              origin={108,78})));
      equation
        connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-58,
                60.6},{-50,60.6},{-50,81.3333},{-38,81.3333}},
                                                    color={0,127,255}));
        connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-58,16.6},{-52,
                16.6},{-52,16},{-44,16},{-44,82},{-38,82}},
                                          color={0,127,255}));
        connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-56,-28},
                {-42,-28},{-42,82.6667},{-38,82.6667}},
                                                     color={0,127,255}));
        connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-26,82},{-20,82},
                {-20,26.6},{-8,26.6}},  color={0,127,255}));
        connect(EM.port_b1, volume1.port_a[1]) annotation (Line(points={{-8,11.4},{-16,
                11.4},{-16,-58},{-24,-58}},color={0,127,255}));
        connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-58,
                45.4},{-48,45.4},{-48,-58.6667},{-36,-58.6667}},
                                                      color={0,127,255}));
        connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-58,1.4},{-46,
                1.4},{-46,-58},{-36,-58}}, color={0,127,255}));
        connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-56,-44},
                {-44,-44},{-44,-57.3333},{-36,-57.3333}},  color={0,127,255}));
        connect(EM.port_b2, BOP.port_a) annotation (Line(points={{28,26.6},{34,26.6},{
                34,25.2},{42,25.2}}, color={0,127,255}));
        connect(EM.port_a2, BOP.port_b) annotation (Line(points={{28,11.4},{34,11.4},{
                34,10.8},{42,10.8}},
                                color={0,127,255}));
        connect(BOP.portElec_b, SY.port_a[1])
          annotation (Line(points={{78,18},{98,18},{98,18.8},{110,18.8}},
                                                     color={255,0,0}));
        connect(EM.port_b3[1], IP.port_a) annotation (Line(points={{17.2,0},{16,0},{16,
                -24},{62,-24}},    color={0,127,255}));
        connect(BOP.port_a3[1], IP.port_b) annotation (Line(points={{52.8,0},{52.8,-40},
                {62,-40}},          color={0,127,255}));
        connect(SY.port_Grid, EG.portElec_a) annotation (Line(points={{148,20},{158,20},
                {158,21},{162,21}}, color={255,0,0}));
        connect(IP.portElec_a, SY.port_a[2]) annotation (Line(points={{104,-32},{104,20},
                {110,20}},              color={255,0,0}));
        connect(windPlant_MultiInstantiate_Day.WindPower, wind_connector_Transform.powerGeneration)
          annotation (Line(points={{35.6667,68.58},{56,68.58},{56,69.52}},
                        color={0,0,127}));
        connect(wind_connector_Transform.portElec_a, breaker.port_a) annotation (Line(
              points={{80,69.2},{80,66},{88,66},{88,63}}, color={255,0,0}));
        connect(breaker.port_b, SY.port_a[3]) annotation (Line(points={{102,63},{106,63},
                {106,21.2},{110,21.2}}, color={255,0,0}));
        connect(lessEqualThreshold.y, breaker.closed) annotation (Line(points={
                {101.4,78},{94,78},{94,68.6},{95,68.6}}, color={255,0,255}));
        connect(clock.y, lessEqualThreshold.u)
          annotation (Line(points={{129.4,78},{115.2,78}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {200,100}})),                                        Diagram(
              coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})),
          experiment(
            StopTime=7200,
            Interval=60,
            __Dymola_Algorithm="Esdirk23a"));
      end Test_NuclearWind_BOP_HTSE_7200_WDisrup;
    end WindTest;

    package SolarTest
      model Test_NuclearSolar_BOP_HTSE_7200_NoDisrup

       parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
       parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
       parameter Integer no_modules=3;
      // parameter Real eff=0.35;

        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-96,42},{-56,82}})));
        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-96,-6},{-56,34}})));
        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-96,-56},{-56,-16}})));
        TRANSFORM.Fluid.Volumes.MixingVolume volume(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          use_T_start=false,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
              (V=0.001),
          nPorts_b=1,
          p_start=PHS.port_b_nominal.p,
          h_start=PHS.port_b_nominal.h,
          nPorts_a=3,
          showName=false)
          annotation (Placement(transformation(extent={{-40,72},{-20,92}})));
        TRANSFORM.Fluid.Volumes.MixingVolume volume1(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          use_T_start=false,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
              (V=0.001),
          nPorts_a=1,
          p_start=PHS.port_a_nominal.p,
          h_start=PHS.port_a_nominal.h,
          nPorts_b=3,
          showName=false)
          annotation (Placement(transformation(extent={{-20,-66},{-40,-46}})));
        NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
          port_a_nominal(
            p=EM.port_b2_nominal.p,
            h=EM.port_b2_nominal.h,
            m_flow=-EM.port_b2_nominal.m_flow),
          port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h), redeclare
            NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
            CS(
            p_nominal=BOP.port_a_nominal.p,
            W_totalSetpoint=SC.W_totalSetpoint_BOP,
            delayStartTCV=0), nPorts_a3=1)
          annotation (Placement(transformation(extent={{42,0},{78,36}})));
         NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=3)                                     annotation (Placement(transformation(extent={{114,0},
                  {152,36}})));
         NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{160,0},
                  {198,34}})));
         NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_boundaries
          EM(port_a1_nominal(
            p=PHS.port_b_nominal.p,
            h=PHS.port_b_nominal.h,
            m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
            port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
          nPorts_b3=1)
          annotation (Placement(transformation(extent={{-8,0},{28,38}})));

        Components.HTSE.SteamControl.HTSESteamFlowCtrl_GenericModular
          IP(
          capacity=51.1454e6,
          redeclare
            Components.HTSE.SteamControl.CS_TightlyCoupled_SteamFlowCtrl_modified CS(
            capacityScaler=IP.capacityScaler,
            delayStart=10,
            W_totalSetpoint=SC.W_totalSetpoint_IP),
          port_a_nominal(m_flow=IP.capacityScaler_steamFlow*9.0942),
          hEX_nuclearHeatAnodeGasRecup_ROM(TTube_out(start=259 + 273.15, fixed=false)),
          returnPump(PR0=62.7/43.1794))
          annotation (Placement(transformation(extent={{56,-52},{98,-12}})));

        Components.WindPlant.Wind_connector_Transform wind_connector_Transform
          annotation (Placement(transformation(extent={{76,62},{102,74}})));
        Solar_BOP_IP_Demand SC(
          delayStart=0,
          W_nominal_BOP=1.710e08,
          Solar_Power=SY.port_a[3].W)
          annotation (Placement(transformation(extent={{140,46},{196,98}})));

        SolarPlant_MultiInstantiate_IradInput
          solarPlant_MultiInstantiate_IradInput
          annotation (Placement(transformation(extent={{40,58},{70,86}})));
      equation
        connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-56,70},
                {-50,70},{-50,81.3333},{-36,81.3333}},
                                                    color={0,127,255}));
        connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-56,22},{-52,
                22},{-52,16},{-44,16},{-44,82},{-36,82}},
                                          color={0,127,255}));
        connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-56,-28},
                {-42,-28},{-42,82.6667},{-36,82.6667}},
                                                     color={0,127,255}));
        connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-24,82},{-20,82},
                {-20,26.6},{-8,26.6}},  color={0,127,255}));
        connect(EM.port_b1, volume1.port_a[1]) annotation (Line(points={{-8,11.4},{-16,
                11.4},{-16,-56},{-24,-56}},color={0,127,255}));
        connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-56,54},
                {-48,54},{-48,-56.6667},{-36,-56.6667}},
                                                      color={0,127,255}));
        connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-56,6},{-46,
                6},{-46,-56},{-36,-56}},   color={0,127,255}));
        connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-56,-44},
                {-44,-44},{-44,-55.3333},{-36,-55.3333}},  color={0,127,255}));
        connect(EM.port_b2, BOP.port_a) annotation (Line(points={{28,26.6},{34,26.6},{
                34,25.2},{42,25.2}}, color={0,127,255}));
        connect(EM.port_a2, BOP.port_b) annotation (Line(points={{28,11.4},{34,11.4},{
                34,10.8},{42,10.8}},
                                color={0,127,255}));
        connect(BOP.portElec_b, SY.port_a[1])
          annotation (Line(points={{78,18},{98,18},{98,16.8},{114,16.8}},
                                                     color={255,0,0}));
        connect(EM.port_b3[1], IP.port_a) annotation (Line(points={{17.2,0},{16,0},{16,
                -24},{56,-24}},    color={0,127,255}));
        connect(BOP.port_a3[1], IP.port_b) annotation (Line(points={{52.8,0},{52.8,-40},
                {56,-40}},          color={0,127,255}));
        connect(SY.port_Grid, EG.portElec_a) annotation (Line(points={{152,18},{158,18},
                {158,17},{160,17}}, color={255,0,0}));
        connect(IP.portElec_a, SY.port_a[2]) annotation (Line(points={{98,-32},{108,-32},
                {108,18},{114,18}},     color={255,0,0}));
        connect(wind_connector_Transform.portElec_a, SY.port_a[3]) annotation (Line(
              points={{102,69.2},{106,69.2},{106,19.2},{114,19.2}},
                                                                color={255,0,0}));
        connect(solarPlant_MultiInstantiate_IradInput.SolarPower,
          wind_connector_Transform.powerGeneration) annotation (Line(points={{71.5,
                69.5111},{74.75,69.5111},{74.75,69.32},{76,69.32}},      color=
                {0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {200,100}})),                                        Diagram(
              coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})),
          experiment(
            StopTime=7200,
            Interval=60,
            __Dymola_Algorithm="Esdirk23a"));
      end Test_NuclearSolar_BOP_HTSE_7200_NoDisrup;

      model SolarPlant_MultiInstantiate
          extends
          NHES.Systems.Templates.SubSystem_Standalone.BaseClasses.Partial_SubSystem_A(
          redeclare replaceable
            NHES.Systems.Templates.SubSystem_Standalone.CS.CS_Dummy CS,
          redeclare replaceable
            NHES.Systems.Templates.SubSystem_Standalone.CS.ED_Dummy ED,
          redeclare NHES.Systems.Templates.SubSystem_Standalone.Data.Data_Dummy
            data);

       parameter Integer no_units=5;

        Modelica.Blocks.Math.MultiSum AggregatedSolarPower(k=fill(1, no_units),nu=no_units)
          annotation (Placement(transformation(extent={{-8,22},{14,44}})));

        PVmodel_Singlephase pv_unit[
          no_units] annotation (Placement(transformation(extent={{-90,20},{-68,42}})));

        Modelica.Blocks.Interfaces.RealOutput SolarPower
          annotation (Placement(transformation(extent={{100,24},{120,44}})));
        Modelica.Blocks.Math.Gain gain(k=10)
          annotation (Placement(transformation(extent={{46,24},{66,44}})));
      equation
        for i in 1:no_units loop
            connect(pv_unit[i].Power, AggregatedSolarPower.u[i]);
        end for;

        connect(AggregatedSolarPower.y, gain.u) annotation (Line(points={{15.87,33},{28.935,
                33},{28.935,34},{44,34}}, color={0,0,127}));
        connect(gain.y, SolarPower)
          annotation (Line(points={{67,34},{110,34}}, color={0,0,127}));
      annotation (
          experiment(
            StopTime=7200,
            Interval=60,
            Tolerance=1e-08,
            __Dymola_Algorithm="Rkfix4"),
          Diagram(coordinateSystem(extent={{-100,-40},{100,140}})),
          Icon(coordinateSystem(extent={{-100,-40},{100,140}})));
      end SolarPlant_MultiInstantiate;

      model PVmodel_Singlephase
        extends Modelica.Icons.Example;
        parameter Integer nsModule = 50 "Number of series connected modules";
        parameter Integer npModule = 20 "Number of parallel connected modules";
        parameter String csvFileName = "TGM_Trina_Analytical_20160629_power.csv";
        PhotoVoltaics.Components.SimplePhotoVoltaics.SimplePlantSymmetric plant(
          moduleData=moduleData,
          npModule=npModule,
          nsModule=nsModule,
          useConstantIrradiance=false) annotation (Placement(visible=true, transformation(
              origin={-48,12},
              extent={{10,-10},{-10,10}},
              rotation=90)));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (
          Placement(visible = true, transformation(origin={-48,-18},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PhotoVoltaics.Components.Converters.QuasiStaticSinglePhaseConverter converter annotation (
          Placement(transformation(extent={{12,2},{32,22}})));
        PhotoVoltaics.Components.Blocks.MPTrackerSample mpTracker(VmpRef = nsModule * moduleData.VmpRef, ImpRef = npModule * moduleData.ImpRef, samplePeriod = 10) annotation (
          Placement(transformation(extent={{-16,-48},{4,-28}})));
        Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundAC
          annotation (Placement(transformation(extent={{62,-28},{82,-8}})));
        Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource
          voltageSource(
          f=50,
          V=230,
          phi=0,
          gamma(start=0, fixed=true)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={72,12})));
        Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor annotation (
          Placement(transformation(extent={{-28,22},{-8,42}})));
        parameter PhotoVoltaics.Records.TSM_230_PC05 moduleData annotation (
          Placement(visible = true, transformation(origin={60,70},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PhotoVoltaics.Sources.Irradiance.Irradiance irradiance(
          startDay=1,
          startMonth=08,
          startYear=2016,
          latitude(displayUnit="deg"))
          annotation (Placement(transformation(extent={{-96,2},{-76,22}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=3*powerSensor.power)
          annotation (Placement(transformation(extent={{40,-56},{60,-36}})));
        Modelica.Blocks.Interfaces.RealOutput Power
          annotation (Placement(transformation(extent={{96,-56},{116,-36}})));
      equation
        connect(ground.p, plant.n) annotation (
          Line(points={{-48,-8},{-48,2}},         color = {0, 0, 255}));
        connect(mpTracker.vRef, converter.vDCRef) annotation (
          Line(points={{5,-38},{16,-38},{16,0}},           color = {0, 0, 127}));
        connect(converter.ac_n, groundAC.pin) annotation (
          Line(points={{32,6},{32,-8},{72,-8}},            color = {85, 170, 255}));
        connect(groundAC.pin, voltageSource.pin_n) annotation (
          Line(points={{72,-8},{72,2}},                    color = {85, 170, 255}));
        connect(powerSensor.nc, converter.dc_p) annotation (
          Line(points={{-8,32},{12,32},{12,18}},                   color = {0, 0, 255}));
        connect(mpTracker.power, powerSensor.power) annotation (
          Line(points={{-18,-38},{-28,-38},{-28,21}},                    color = {0, 0, 127}));
        connect(powerSensor.pc, powerSensor.pv) annotation (
          Line(points={{-28,32},{-28,42},{-18,42}},        color = {0, 0, 255}));
        connect(converter.ac_p, voltageSource.pin_p) annotation (
          Line(points={{32,18},{32,32},{72,32},{72,22}},                 color = {85, 170, 255}));
        connect(plant.p, powerSensor.pc) annotation (
          Line(points={{-48,22},{-48,32},{-28,32}},       color = {0, 0, 255}));
        connect(powerSensor.nv, ground.p) annotation (
          Line(points={{-18,22},{-18,-8},{-48,-8}},                               color = {0, 0, 255}));
        connect(ground.p, converter.dc_n) annotation (
          Line(points={{-48,-8},{12,-8},{12,6}},            color = {0, 0, 255}));
        connect(irradiance.irradiance, plant.variableIrradiance)
          annotation (Line(points={{-75,12},{-60,12}}, color={0,0,127}));
        connect(realExpression.y, Power)
          annotation (Line(points={{61,-46},{106,-46}}, color={0,0,127}));
        annotation (
          experiment(StopTime = 86400, Interval = 60, Tolerance = 1e-08, __Dymola_Algorithm = "Rkfix4"),
          Diagram(coordinateSystem(extent={{-120,-100},{100,100}})),
          Icon(coordinateSystem(extent={{-120,-100},{100,100}})));
      end PVmodel_Singlephase;

      model Solar_BOP_IP_Demand
        extends NHES.Systems.SupervisoryControl.BaseClasses.Partial_ControlSystem;

        parameter Real delayStart=500 "Time to start tracking power profiles";
        parameter Modelica.Units.SI.Time timeScale=1800
          "Time scale of first table column";

        parameter Modelica.Units.SI.Power W_nominal_BOP=4.13285e8 "Nominal BOP Power";

        parameter Modelica.Units.SI.Power W_IP_nom(displayUnit="MW")=51.1454e6
          "Nominal electrical power consumption in the IP";
        final parameter Modelica.Units.SI.Power W_IP_max(displayUnit="MW")=
          W_IP_nom "Maximum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power W_IP_min(displayUnit="MW")=20.9561e6
          "Minimum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power HTSE_Q=18.5;
        parameter Real HTSE_eff=0.35;

        input Modelica.Units.SI.Power Solar_Power "Solar power";

        output Modelica.Units.SI.Power W_totalSetpoint_BOP=switch_BOP.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_EG=switch_EG.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_IP=switch_IP.y
          annotation (Dialog(group="Outputs", enable=false));
        parameter String fileName=Modelica.Utilities.Files.loadResource(
            "C:/Users/raj180002/OneDrive - The University of Texas at Dallas/Dymola/Journal_NHES_Data/HIL Data/Demand_Alter.txt")
          "File where matrix is stored";

        Modelica.Blocks.Logical.LessThreshold greaterEqualThreshold1(threshold=
              delayStart)
          annotation (Placement(transformation(extent={{-112,18},{-92,38}})));
        Modelica.Blocks.Logical.Switch switch_BOP
          annotation (Placement(transformation(extent={{2,108},{22,128}})));
        Modelica.Blocks.Sources.Constant BOP_nominal(k=1.71e08)
          annotation (Placement(transformation(extent={{-44,132},{-24,152}})));

        Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
          annotation (Placement(transformation(extent={{-160,18},{-140,38}})));

        Modelica.Blocks.Logical.Switch switch_EG
          annotation (Placement(transformation(extent={{44,18},{64,38}})));
        Modelica.Blocks.Logical.Switch switch_IP
          annotation (Placement(transformation(extent={{48,-78},{68,-58}})));
        Modelica.Blocks.Sources.Constant HTSE_nominal(k=51e06)
          annotation (Placement(transformation(extent={{-36,-54},{-16,-34}})));
        Modelica.Blocks.Sources.RealExpression IPDemand(y=BOP_nominal.y +
              Solar_Power - HTSE_Q*HTSE_eff - GridDemand.y)
          annotation (Placement(transformation(extent={{-72,-120},{-52,-100}})));
        Modelica.Blocks.Sources.RealExpression BOPDemand(y=GridDemand.y +
              limiter_HTSE_W.y - Solar_Power)
          annotation (Placement(transformation(extent={{-46,94},{-26,114}})));
        Modelica.Blocks.Nonlinear.Limiter limiter_HTSE_W(uMax=W_IP_max, uMin=W_IP_min)
          annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={-12,-94})));
        Modelica.Blocks.Sources.RealExpression Grid_nominal(y=BOP_nominal.y -
              HTSE_nominal.y)
          annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
        Modelica.Blocks.Sources.CombiTimeTable demand_EG(
          tableOnFile=true,
          timeScale=1,
          startTime=delayStart,
          tableName="Grid",
          fileName=fileName)
          annotation (Placement(transformation(extent={{-54,-6},{-34,14}})));
        Modelica.Blocks.Math.Gain GridDemand(k=1.71e08)
          annotation (Placement(transformation(extent={{-16,-6},{4,14}})));
      equation
        connect(BOP_nominal.y, switch_BOP.u1) annotation (Line(points={{-23,142},{-6,142},
                {-6,126},{0,126}},         color={0,0,127}));
        connect(clock.y, greaterEqualThreshold1.u)
          annotation (Line(points={{-139,28},{-114,28}},           color={0,0,127}));
        connect(greaterEqualThreshold1.y, switch_BOP.u2) annotation (Line(points={{-91,28},
                {-72,28},{-72,118},{0,118}},     color={255,0,255}));
        connect(switch_EG.u2, switch_BOP.u2) annotation (Line(points={{42,28},{-72,28},
                {-72,118},{0,118}},                    color={255,0,255}));
        connect(switch_IP.u2, switch_BOP.u2) annotation (Line(points={{46,-68},{-72,-68},
                {-72,118},{0,118}}, color={255,0,255}));
        connect(HTSE_nominal.y, switch_IP.u1) annotation (Line(points={{-15,-44},{30,-44},
                {30,-60},{46,-60}}, color={0,0,127}));
        connect(BOPDemand.y, switch_BOP.u3) annotation (Line(points={{-25,104},{-10,104},
                {-10,110},{0,110}}, color={0,0,127}));
        connect(IPDemand.y, limiter_HTSE_W.u)
          annotation (Line(points={{-51,-110},{-42,-110},{-42,-94},{-24,-94}},
                                                         color={0,0,127}));
        connect(limiter_HTSE_W.y, switch_IP.u3) annotation (Line(points={{-1,-94},
                {30,-94},{30,-76},{46,-76}},
                                         color={0,0,127}));
        connect(Grid_nominal.y, switch_EG.u1) annotation (Line(points={{-25,60},{14,60},
                {14,36},{42,36}}, color={0,0,127}));
        connect(demand_EG.y[1], GridDemand.u)
          annotation (Line(points={{-33,4},{-18,4}}, color={0,0,127}));
        connect(GridDemand.y, switch_EG.u3)
          annotation (Line(points={{5,4},{24,4},{24,20},{42,20}}, color={0,0,127}));
      annotation(defaultComponentName="SC", experiment(
            StopTime=7200,
            Interval=60,
            __Dymola_Algorithm="Dassl"),
          Diagram(coordinateSystem(extent={{-180,-160},{160,160}})),
          Icon(coordinateSystem(extent={{-180,-160},{160,160}}), graphics={
                        Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Input Setpoints: Modelica Path")}));
      end Solar_BOP_IP_Demand;

      model PVmodel_Singlephase_IradInput
        extends Modelica.Icons.Example;
        parameter Integer nsModule = 50 "Number of series connected modules";
        parameter Integer npModule = 20 "Number of parallel connected modules";
        parameter String csvFileName = "TGM_Trina_Analytical_20160629_power.csv";
        PhotoVoltaics.Components.SimplePhotoVoltaics.SimplePlantSymmetric plant(
          moduleData=moduleData,
          npModule=npModule,
          nsModule=nsModule,
          useConstantIrradiance=false) annotation (Placement(visible=true, transformation(
              origin={-44,18},
              extent={{10,-10},{-10,10}},
              rotation=90)));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (
          Placement(visible = true, transformation(origin={-44,-12},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        PhotoVoltaics.Components.Converters.QuasiStaticSinglePhaseConverter converter annotation (
          Placement(transformation(extent={{16,8},{36,28}})));
        PhotoVoltaics.Components.Blocks.MPTrackerSample mpTracker(VmpRef = nsModule * moduleData.VmpRef, ImpRef = npModule * moduleData.ImpRef,
          samplePeriod=60,
          n=1000)                                                                                                                                                  annotation (
          Placement(transformation(extent={{-12,-34},{8,-14}})));
        Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundAC
          annotation (Placement(transformation(extent={{66,-22},{86,-2}})));
        Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource
          voltageSource(
          f=50,
          V=230,
          phi=0,
          gamma(start=0, fixed=true)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={76,18})));
        Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor annotation (
          Placement(transformation(extent={{-24,28},{-4,48}})));
        parameter PhotoVoltaics.Records.TSM_230_PC05 moduleData annotation (
          Placement(visible = true, transformation(origin={70,78},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Sources.RealExpression realExpression(y=3*powerSensor.power)
          annotation (Placement(transformation(extent={{44,-50},{64,-30}})));
        Modelica.Blocks.Interfaces.RealOutput Power
          annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
        Modelica.Blocks.Sources.CombiTimeTable solar_irrad(
          tableOnFile=true,
          timeScale=1,
          startTime=0,
          tableName="Solar",
          fileName=
              "C:/Users/raj180002/OneDrive - The University of Texas at Dallas/Dymola/Journal_NHES_Data/HIL Data/Solar_Irradiance.txt")
          annotation (Placement(transformation(extent={{-94,8},{-74,28}})));
      equation
        connect(ground.p, plant.n) annotation (
          Line(points={{-44,-2},{-44,8}},         color = {0, 0, 255}));
        connect(mpTracker.vRef, converter.vDCRef) annotation (
          Line(points={{9,-24},{20,-24},{20,6}},           color = {0, 0, 127}));
        connect(converter.ac_n, groundAC.pin) annotation (
          Line(points={{36,12},{36,-2},{76,-2}},           color = {85, 170, 255}));
        connect(groundAC.pin, voltageSource.pin_n) annotation (
          Line(points={{76,-2},{76,8}},                    color = {85, 170, 255}));
        connect(powerSensor.nc, converter.dc_p) annotation (
          Line(points={{-4,38},{16,38},{16,24}},                   color = {0, 0, 255}));
        connect(mpTracker.power, powerSensor.power) annotation (
          Line(points={{-14,-24},{-24,-24},{-24,27}},                    color = {0, 0, 127}));
        connect(powerSensor.pc, powerSensor.pv) annotation (
          Line(points={{-24,38},{-24,48},{-14,48}},        color = {0, 0, 255}));
        connect(converter.ac_p, voltageSource.pin_p) annotation (
          Line(points={{36,24},{36,38},{76,38},{76,28}},                 color = {85, 170, 255}));
        connect(plant.p, powerSensor.pc) annotation (
          Line(points={{-44,28},{-44,38},{-24,38}},       color = {0, 0, 255}));
        connect(powerSensor.nv, ground.p) annotation (
          Line(points={{-14,28},{-14,-2},{-44,-2}},                               color = {0, 0, 255}));
        connect(ground.p, converter.dc_n) annotation (
          Line(points={{-44,-2},{16,-2},{16,12}},           color = {0, 0, 255}));
        connect(realExpression.y, Power)
          annotation (Line(points={{65,-40},{110,-40}}, color={0,0,127}));
        connect(solar_irrad.y[1], plant.variableIrradiance)
          annotation (Line(points={{-73,18},{-56,18}}, color={0,0,127}));
        annotation (
          experiment(
            StopTime=7200,
            Interval=60,
            Tolerance=1e-08,
            __Dymola_Algorithm="Esdirk23a"),
          Diagram(coordinateSystem(extent={{-100,-80},{100,100}})),
          Icon(coordinateSystem(extent={{-100,-80},{100,100}})));
      end PVmodel_Singlephase_IradInput;

      model SolarPlant_MultiInstantiate_IradInput
          extends
          NHES.Systems.Templates.SubSystem_Standalone.BaseClasses.Partial_SubSystem_A(
          redeclare replaceable
            NHES.Systems.Templates.SubSystem_Standalone.CS.CS_Dummy CS,
          redeclare replaceable
            NHES.Systems.Templates.SubSystem_Standalone.CS.ED_Dummy ED,
          redeclare NHES.Systems.Templates.SubSystem_Standalone.Data.Data_Dummy
            data);

       parameter Integer no_units=5;

        Modelica.Blocks.Math.MultiSum AggregatedSolarPower(k=fill(1, no_units),nu=no_units)
          annotation (Placement(transformation(extent={{-20,24},{2,46}})));

         PVmodel_Singlephase_IradInput pv_unit[
          no_units] annotation (Placement(transformation(extent={{-86,34},{-68,
                  50}})));

        Modelica.Blocks.Interfaces.RealOutput SolarPower
          annotation (Placement(transformation(extent={{100,24},{120,44}})));
        Modelica.Blocks.Math.Gain gain(k=10)
          annotation (Placement(transformation(extent={{46,24},{66,44}})));
      equation
        for i in 1:no_units loop
            connect(pv_unit[i].Power, AggregatedSolarPower.u[i]);
        end for;

        connect(AggregatedSolarPower.y, gain.u) annotation (Line(points={{3.87,35},
                {28.935,35},{28.935,34},{44,34}},
                                          color={0,0,127}));
        connect(gain.y, SolarPower)
          annotation (Line(points={{67,34},{110,34}}, color={0,0,127}));
      annotation (
          experiment(
            StopTime=7200,
            Interval=60,
            Tolerance=1e-08,
            __Dymola_Algorithm="Esdirk45a"),
          Diagram(coordinateSystem(extent={{-100,-40},{100,140}})),
          Icon(coordinateSystem(extent={{-100,-40},{100,140}})));
      end SolarPlant_MultiInstantiate_IradInput;

      model Test



        Solar_BOP_IP_Demand SC(
          delayStart=500,
          W_nominal_BOP=1.710e08,
          Solar_Power=solarPlant_MultiInstantiate_IradInput.SolarPower)
          annotation (Placement(transformation(extent={{100,-14},{172,54}})));

        SolarPlant_MultiInstantiate_IradInput solarPlant_MultiInstantiate_IradInput
          annotation (Placement(transformation(extent={{2,12},{42,48}})));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {200,100}})),                                        Diagram(
              coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})),
          experiment(
            StopTime=7200,
            Interval=60,
            __Dymola_Algorithm="Esdirk23a"));
      end Test;

      model Test_NuclearSolar_BOP_HTSE_7200_WDisrup

       parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
       parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
       parameter Integer no_modules=3;
      // parameter Real eff=0.35;

        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-96,42},{-56,82}})));
        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-96,-6},{-56,34}})));
        NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(
            redeclare
            NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
          annotation (Placement(transformation(extent={{-96,-56},{-56,-16}})));
        TRANSFORM.Fluid.Volumes.MixingVolume volume(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          use_T_start=false,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
              (V=0.001),
          nPorts_b=1,
          p_start=PHS.port_b_nominal.p,
          h_start=PHS.port_b_nominal.h,
          nPorts_a=3,
          showName=false)
          annotation (Placement(transformation(extent={{-40,72},{-20,92}})));
        TRANSFORM.Fluid.Volumes.MixingVolume volume1(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          use_T_start=false,
          redeclare model Geometry =
              TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
              (V=0.001),
          nPorts_a=1,
          p_start=PHS.port_a_nominal.p,
          h_start=PHS.port_a_nominal.h,
          nPorts_b=3,
          showName=false)
          annotation (Placement(transformation(extent={{-20,-66},{-40,-46}})));
        NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
          port_a_nominal(
            p=EM.port_b2_nominal.p,
            h=EM.port_b2_nominal.h,
            m_flow=-EM.port_b2_nominal.m_flow),
          port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h), redeclare
            NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
            CS(
            p_nominal=BOP.port_a_nominal.p,
            W_totalSetpoint=SC.W_totalSetpoint_BOP,
            delayStartTCV=0), nPorts_a3=1)
          annotation (Placement(transformation(extent={{42,0},{78,36}})));
         NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=3)                                     annotation (Placement(transformation(extent={{114,0},
                  {152,36}})));
         NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{160,0},
                  {198,34}})));
         NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_boundaries
          EM(port_a1_nominal(
            p=PHS.port_b_nominal.p,
            h=PHS.port_b_nominal.h,
            m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
            port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
          nPorts_b3=1)
          annotation (Placement(transformation(extent={{-8,0},{28,38}})));

        Components.HTSE.SteamControl.HTSESteamFlowCtrl_GenericModular
          IP(
          capacity=51.1454e6,
          redeclare
            Components.HTSE.SteamControl.CS_TightlyCoupled_SteamFlowCtrl_modified CS(
            capacityScaler=IP.capacityScaler,
            delayStart=10,
            W_totalSetpoint=SC.W_totalSetpoint_IP),
          port_a_nominal(m_flow=IP.capacityScaler_steamFlow*9.0942),
          hEX_nuclearHeatAnodeGasRecup_ROM(TTube_out(start=259 + 273.15, fixed=false)),
          returnPump(PR0=62.7/43.1794))
          annotation (Placement(transformation(extent={{56,-52},{98,-12}})));

        Components.WindPlant.Wind_connector_Transform wind_connector_Transform
          annotation (Placement(transformation(extent={{76,62},{102,74}})));
        Solar_BOP_IP_Demand_Disrup SC(
          delayStart=0,
          W_nominal_BOP=1.710e08,
          Solar_Power=SY.port_a[3].W)
          annotation (Placement(transformation(extent={{150,46},{206,98}})));

        SolarPlant_MultiInstantiate_IradInput
          solarPlant_MultiInstantiate_IradInput
          annotation (Placement(transformation(extent={{-6,58},{28,88}})));
        NHES.Electrical.Breaker breaker
          annotation (Placement(transformation(extent={{100,64},{112,76}})));
        Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=3600)
                   annotation (Placement(transformation(
              extent={{-6,-6},{6,6}},
              rotation=180,
              origin={118,90})));
        Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
          annotation (Placement(transformation(extent={{-6,-6},{6,6}},
              rotation=180,
              origin={144,90})));
      equation
        connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-56,70},
                {-50,70},{-50,81.3333},{-36,81.3333}},
                                                    color={0,127,255}));
        connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-56,22},{-52,
                22},{-52,16},{-44,16},{-44,82},{-36,82}},
                                          color={0,127,255}));
        connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-56,-28},
                {-42,-28},{-42,82.6667},{-36,82.6667}},
                                                     color={0,127,255}));
        connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-24,82},{-20,82},
                {-20,26.6},{-8,26.6}},  color={0,127,255}));
        connect(EM.port_b1, volume1.port_a[1]) annotation (Line(points={{-8,11.4},{-16,
                11.4},{-16,-56},{-24,-56}},color={0,127,255}));
        connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-56,54},
                {-48,54},{-48,-56.6667},{-36,-56.6667}},
                                                      color={0,127,255}));
        connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-56,6},{-46,
                6},{-46,-56},{-36,-56}},   color={0,127,255}));
        connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-56,-44},
                {-44,-44},{-44,-55.3333},{-36,-55.3333}},  color={0,127,255}));
        connect(EM.port_b2, BOP.port_a) annotation (Line(points={{28,26.6},{34,26.6},{
                34,25.2},{42,25.2}}, color={0,127,255}));
        connect(EM.port_a2, BOP.port_b) annotation (Line(points={{28,11.4},{34,11.4},{
                34,10.8},{42,10.8}},
                                color={0,127,255}));
        connect(BOP.portElec_b, SY.port_a[1])
          annotation (Line(points={{78,18},{98,18},{98,16.8},{114,16.8}},
                                                     color={255,0,0}));
        connect(EM.port_b3[1], IP.port_a) annotation (Line(points={{17.2,0},{16,0},{16,
                -24},{56,-24}},    color={0,127,255}));
        connect(BOP.port_a3[1], IP.port_b) annotation (Line(points={{52.8,0},{52.8,-40},
                {56,-40}},          color={0,127,255}));
        connect(SY.port_Grid, EG.portElec_a) annotation (Line(points={{152,18},{158,18},
                {158,17},{160,17}}, color={255,0,0}));
        connect(IP.portElec_a, SY.port_a[2]) annotation (Line(points={{98,-32},{108,-32},
                {108,18},{114,18}},     color={255,0,0}));
        connect(solarPlant_MultiInstantiate_IradInput.SolarPower,
          wind_connector_Transform.powerGeneration) annotation (Line(points={{29.7,
                70.3333},{74.75,70.3333},{74.75,69.32},{76,69.32}},      color=
                {0,0,127}));
        connect(wind_connector_Transform.portElec_a, breaker.port_a)
          annotation (Line(points={{102,69.2},{102,70},{100,70}}, color={255,0,0}));
        connect(breaker.port_b, SY.port_a[3]) annotation (Line(points={{112,70},{112,20},
                {114,20},{114,19.2}}, color={255,0,0}));
        connect(lessEqualThreshold.y, breaker.closed) annotation (Line(points={{111.4,
                90},{106,90},{106,74.8}}, color={255,0,255}));
        connect(clock.y, lessEqualThreshold.u)
          annotation (Line(points={{137.4,90},{125.2,90}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {200,100}})),                                        Diagram(
              coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})),
          experiment(
            StopTime=7200,
            Interval=60,
            __Dymola_Algorithm="Esdirk23a"));
      end Test_NuclearSolar_BOP_HTSE_7200_WDisrup;

      model Solar_BOP_IP_Demand_Disrup
        extends NHES.Systems.SupervisoryControl.BaseClasses.Partial_ControlSystem;

        parameter Real delayStart=500 "Time to start tracking power profiles";
        parameter Modelica.Units.SI.Time timeScale=1800
          "Time scale of first table column";

        parameter Modelica.Units.SI.Power W_nominal_BOP=4.13285e8 "Nominal BOP Power";

        parameter Modelica.Units.SI.Power W_IP_nom(displayUnit="MW")=51.1454e6
          "Nominal electrical power consumption in the IP";
        final parameter Modelica.Units.SI.Power W_IP_max(displayUnit="MW")=
          W_IP_nom "Maximum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power W_IP_min(displayUnit="MW")=20.9561e6
          "Minimum electrical power consumption in the IP";
        parameter Modelica.Units.SI.Power HTSE_Q=18.5;
        parameter Real HTSE_eff=0.35;

        input Modelica.Units.SI.Power Solar_Power "Solar power";

        output Modelica.Units.SI.Power W_totalSetpoint_BOP=switch_BOP.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_EG=switch_EG.y
          annotation (Dialog(group="Outputs", enable=false));

        output Modelica.Units.SI.Power W_totalSetpoint_IP=switch_IP.y
          annotation (Dialog(group="Outputs", enable=false));
        parameter String fileName=Modelica.Utilities.Files.loadResource(
            "C:/Users/raj180002/OneDrive - The University of Texas at Dallas/Dymola/Journal_NHES_Data/HIL Data/Demand_Disrup.txt")
          "File where matrix is stored";

        Modelica.Blocks.Logical.LessThreshold greaterEqualThreshold1(threshold=
              delayStart)
          annotation (Placement(transformation(extent={{-112,18},{-92,38}})));
        Modelica.Blocks.Logical.Switch switch_BOP
          annotation (Placement(transformation(extent={{2,108},{22,128}})));
        Modelica.Blocks.Sources.Constant BOP_nominal(k=1.71e08)
          annotation (Placement(transformation(extent={{-44,132},{-24,152}})));

        Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
          annotation (Placement(transformation(extent={{-160,18},{-140,38}})));

        Modelica.Blocks.Logical.Switch switch_EG
          annotation (Placement(transformation(extent={{44,18},{64,38}})));
        Modelica.Blocks.Logical.Switch switch_IP
          annotation (Placement(transformation(extent={{48,-78},{68,-58}})));
        Modelica.Blocks.Sources.Constant HTSE_nominal(k=51e06)
          annotation (Placement(transformation(extent={{-36,-54},{-16,-34}})));
        Modelica.Blocks.Sources.RealExpression IPDemand(y=BOP_nominal.y +
              Solar_Power - HTSE_Q*HTSE_eff - GridDemand.y)
          annotation (Placement(transformation(extent={{-72,-120},{-52,-100}})));
        Modelica.Blocks.Sources.RealExpression BOPDemand(y=GridDemand.y +
              limiter_HTSE_W.y - Solar_Power)
          annotation (Placement(transformation(extent={{-46,94},{-26,114}})));
        Modelica.Blocks.Nonlinear.Limiter limiter_HTSE_W(uMax=W_IP_max, uMin=W_IP_min)
          annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={-12,-94})));
        Modelica.Blocks.Sources.RealExpression Grid_nominal(y=BOP_nominal.y -
              HTSE_nominal.y)
          annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
        Modelica.Blocks.Sources.CombiTimeTable demand_EG(
          tableOnFile=true,
          timeScale=1,
          startTime=delayStart,
          tableName="Grid",
          fileName=fileName)
          annotation (Placement(transformation(extent={{-54,-6},{-34,14}})));
        Modelica.Blocks.Math.Gain GridDemand(k=1.71e08)
          annotation (Placement(transformation(extent={{-16,-6},{4,14}})));
      equation
        connect(BOP_nominal.y, switch_BOP.u1) annotation (Line(points={{-23,142},{-6,142},
                {-6,126},{0,126}},         color={0,0,127}));
        connect(clock.y, greaterEqualThreshold1.u)
          annotation (Line(points={{-139,28},{-114,28}},           color={0,0,127}));
        connect(greaterEqualThreshold1.y, switch_BOP.u2) annotation (Line(points={{-91,28},
                {-72,28},{-72,118},{0,118}},     color={255,0,255}));
        connect(switch_EG.u2, switch_BOP.u2) annotation (Line(points={{42,28},{-72,28},
                {-72,118},{0,118}},                    color={255,0,255}));
        connect(switch_IP.u2, switch_BOP.u2) annotation (Line(points={{46,-68},{-72,-68},
                {-72,118},{0,118}}, color={255,0,255}));
        connect(HTSE_nominal.y, switch_IP.u1) annotation (Line(points={{-15,-44},{30,-44},
                {30,-60},{46,-60}}, color={0,0,127}));
        connect(BOPDemand.y, switch_BOP.u3) annotation (Line(points={{-25,104},{-10,104},
                {-10,110},{0,110}}, color={0,0,127}));
        connect(IPDemand.y, limiter_HTSE_W.u)
          annotation (Line(points={{-51,-110},{-42,-110},{-42,-94},{-24,-94}},
                                                         color={0,0,127}));
        connect(limiter_HTSE_W.y, switch_IP.u3) annotation (Line(points={{-1,-94},
                {30,-94},{30,-76},{46,-76}},
                                         color={0,0,127}));
        connect(Grid_nominal.y, switch_EG.u1) annotation (Line(points={{-25,60},{14,60},
                {14,36},{42,36}}, color={0,0,127}));
        connect(demand_EG.y[1], GridDemand.u)
          annotation (Line(points={{-33,4},{-18,4}}, color={0,0,127}));
        connect(GridDemand.y, switch_EG.u3)
          annotation (Line(points={{5,4},{24,4},{24,20},{42,20}}, color={0,0,127}));
      annotation(defaultComponentName="SC", experiment(
            StopTime=7200,
            Interval=60,
            __Dymola_Algorithm="Dassl"),
          Diagram(coordinateSystem(extent={{-180,-160},{160,160}})),
          Icon(coordinateSystem(extent={{-180,-160},{160,160}}), graphics={
                        Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Input Setpoints: Modelica Path")}));
      end Solar_BOP_IP_Demand_Disrup;
    end SolarTest;
  end HILExperiments;
  annotation (uses(
      Modelica(version="4.0.0"),
      NHES(version="2"),
      TRANSFORM(version="0.5"),
      WindPowerPlants(version="2"),
      PhotoVoltaics(version="1.6.1")));
end Journal_IES_Simulations;
