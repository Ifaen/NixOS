{user, ...}: {
  user-manage.xdg.dataFile = {
    # System configuration
    "DaVinciResolve/configs/config.dat".text = ''
      Site.Count = 1

      Site.1.LocalEnabled = 1

      Site.1.Svc.Count = 7
      Site.1.Svc.1 = SyManager.1
      Site.1.Svc.2 = GsManager.1
      Site.1.Svc.3 = DpManager.1
      Site.1.Svc.4 = DtManager.1
      Site.1.Svc.5 = LsManager.1
      Site.1.Svc.6 = LsManager.2
      Site.1.Svc.7 = LsManager.3

      Site.1.FS.Count = 2

      Site.1.FS.1.Type = IOFileSys
      Site.1.FS.1.Root = ${user.home}/Media/DaVinci Resolve
      Site.1.FS.1.MappedRoot =
      Site.1.FS.1.DIO = 1
      Site.1.FS.1.BrightClip = 0

      Site.1.FS.2.Type = IOFileSys
      Site.1.FS.2.Root = ResolveVirtual
      Site.1.FS.2.MappedRoot =
      Site.1.FS.2.DIO = 0
      Site.1.FS.2.BrightClip = 0

      Site.1.CmdRT.Count = 1
      Site.1.CmdRT.1.Type = Mem

      Site.1.DataRT.Count = 1
      Site.1.DataRT.1.Type = Mem

      SyManager.Count = 1
      SyManager.1.Guid = 10

      GsManager.Count = 1
      GsManager.1.Guid = 20

      DtManager.Count = 1
      DtManager.1.Guid = 50

      DpManager.Count = 1
      DpManager.Output.Processing = yes
      DpManager.Display.Type = rgb10

      DpManager.1.Guid = 60
      DpManager.1.Output.Count = 2
      DpManager.1.Output.1.Type = VGA
      DpManager.1.Output.2.Type = WFM
      DpManager.1.Output.Processing.Type = hardware
      DpManager.1.Lut.Process = hardware

      LsManager.Count = 3

      LsManager.1.Guid = 30
      LsManager.1.Algo.1 = IpWindowTrackingObj

      LsManager.2.Guid = 31
      LsManager.2.Algo.1 = IpConvertObj
      LsManager.2.Processing = Input

      LsManager.3.Guid = 32
      LsManager.3.Algo.1 = IpVaGPUGraphObj
      LsManager.3.Processing = InputOutput
      Custom.LUT.Path.Count = 0

      Local.Resource.Processors.1 = 2

      Local.Resource.Buffers.1 = 6094

      Local.Resource.ResolveMemoryPercentage = 75
      Local.Resource.FusionMemoryPercentage = 49

      Local.Gui.AutoStart = 1
      Local.Gui.UseTex = 1
      Local.Gui.ENABLEPBO = 1
      Local.Gui.ENABLESDI = 0
      Decklink.Monitor.Index = 0
      Decklink.LiveGrade.Index = 0
      Decklink.Audio.Delay = 0
      Local.Gui.CombineClips = 1

      Local.DtManager.1.Threads = 8
      Local.DtManager.1.Red.Threads = 8

      Local.Audio.Type = DeckLink

      RenderCaching.DtGuid = 50
      RenderCaching.FsNo = 1
      RenderCaching.CacheDir = CacheClip
      RenderCaching.CacheMaxNum = 10000

      System.Gallery.DtMgr.Guid = 50
      System.Gallery.DtMgr.FileSys = 1
      System.Gallery.Folder = .gallery

      System.Playback.Policy = RoundRobin

      System.Playback.Lookahead = 20
      System.Record.Lookahead = 0
      System.VTR.Type = DeckLink

      System.Panel.Type = none
      System.Panel.Model = none

      DPDecoder.Count = 1
      DPDecoder.1.IP = localhost
      DPDecoder.1.Instances = 8

      Red.Rocket.Enable = 2

      Braw.GPU.Enable = 1
      Red.GPU.Enable = 1
      IO.EasyDCPDecoder.Enable = 0
      Local.IO.EnableBMDCloudStreaming = 1

      Local.DNE.Mode = 0
      Local.OpenVINO.Enable = 1
      Local.DirectML.Enable = 1
      Local.TensorRT.Enable = 1

      Local.IO.HardwareAccDecode = 1
      Local.IO.HardwareDecodeMask = 135
      Local.IO.EnableAutoFileRescan = 0

      Local.Audio.DeckLink = 0

      Local.GUI.UseFloatGLPixelFormat = 0
      Local.GUI.ShowAllMountedVolumes = 1
      Local.GUI.EnableDisplayColorProfile = 0
      System.Db.EnablePSQLProxy = 0
      Local.GUI.Tag709ClipsAs709A = 0
      Local.GUI.ReleaseSDIOnFocusLoss = 0
      System.Presentations.LimitUploadRate = 0
      System.Presentations.UploadRate = 500
      Local.GPU.Scopes = 1
      System.Scripting.Mode = 1
      Local.RemoteStream.Enable = 0

      Local.Audio.VSTDirs.Count = 1
      Local.Audio.VSTDirs.1.Path = /usr/lib/vst3/
      Local.Audio.DefaultVST3DirsAdded = 1
      System.Proxy.Mode = 1
      System.FrameIO.CacheDir = ${user.home}/Media/DaVinci Resolve/CacheClip

      Update.AutoCheck.Enabled = 1

      Update.AutoCheck.OptInNewBetaPrograms = 0

      RemoteRender.AutoScan.OtherDBs = 0

      Local.GUI.PreventSystemSleep = 1
      CrashReport.Enable = 0
      CrashReport.AutoSend = 0
    '';

    # User Configuration
    "DaVinciResolve/configs/config.user.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!--DbAppVer="18.6.6.0007" DbPrjVer="13"-->
      <SM_UserPrefs DbId="c1d8546e-a753-4297-8092-834c810aaf58">
      <FieldsBlob/>
      <Name/>
      <Language>en</Language>
      <IsGrayUserInterfaceEnabled>true</IsGrayUserInterfaceEnabled>
      <StopPlaybackOnDropFrame>false</StopPlaybackOnDropFrame>
      <IsStopRenderOnError>true</IsStopRenderOnError>
      <ReviewBeforeUpload>false</ReviewBeforeUpload>
      <VODelayViewerInFrames>0</VODelayViewerInFrames>
      <VODelayViewerEnabled>false</VODelayViewerEnabled>
      <VODisableGUIReadbackforSDI>false</VODisableGUIReadbackforSDI>
      <ReturnPlayheadToStartPosition>false</ReturnPlayheadToStartPosition>
      <AutoSaveMode>0</AutoSaveMode>
      <AutoSaveDuration>10</AutoSaveDuration>
      <NumAutoSaveBackups>8</NumAutoSaveBackups>
      <NumHourlyBackups>2</NumHourlyBackups>
      <NumDailyBackups>2</NumDailyBackups>
      <IsLiveSaveEnabled>false</IsLiveSaveEnabled>
      <IsProjectLiveSaveEnabled>true</IsProjectLiveSaveEnabled>
      <IsLoadAllTimelinesEnabled>false</IsLoadAllTimelinesEnabled>
      <IsTimelineBackupsEnabled>true</IsTimelineBackupsEnabled>
      <AutoReloadPrevProj>false</AutoReloadPrevProj>
      <LastWorkingProject/>
      <LastWorkingProjectFolder/>
      <ShowFocusIndicators>false</ShowFocusIndicators>
      <ProjectBackupLocation>${user.home}/Media/DaVinci Resolve/Resolve Project Backups/</ProjectBackupLocation>
      <GreyBackground>true</GreyBackground>
      <SmartBinForTimelines>false</SmartBinForTimelines>
      <SmartBinForKeywords>true</SmartBinForKeywords>
      <SmartBinForCollections>true</SmartBinForCollections>
      <SmartBinForPeople>false</SmartBinForPeople>
      <SmartBinForShot>false</SmartBinForShot>
      <SmartBinForScene>false</SmartBinForScene>
      <VectorRankMode>0</VectorRankMode>
      <ScopesScaleType>0</ScopesScaleType>
      <OutputFieldInStopMode>false</OutputFieldInStopMode>
      <HighContrastMatte>false</HighContrastMatte>
      <PanelSensitivity>
        <SM_PanelSensitivity DbId="feae8774-433f-4cd4-bdd5-69e01d5cf18d">
        <FieldsBlob/>
        <BallA>50</BallA>
        <BallB>50</BallB>
        <BallC>50</BallC>
        <HueQual>50</HueQual>
        <SatQual>50</SatQual>
        <LumQual>50</LumQual>
        <BallD>50</BallD>
        <RingA>50</RingA>
        <RingB>50</RingB>
        <RingC>50</RingC>
        <RingD>50</RingD>
        </SM_PanelSensitivity>
      </PanelSensitivity>
      <DisplaySquarePixAR>true</DisplaySquarePixAR>
      <StepFrameOffset>0</StepFrameOffset>
      <DefaultNumberOfHandleFrames>24</DefaultNumberOfHandleFrames>
      <DefaultFastNudgeFrames>5</DefaultFastNudgeFrames>
      <PrePlayheadShadowFrames>5</PrePlayheadShadowFrames>
      <PostPlayheadShadowFrames>5</PostPlayheadShadowFrames>
      <RetainTimelineOverlayAction>false</RetainTimelineOverlayAction>
      <EnableSmartClipNavigation>false</EnableSmartClipNavigation>
      <HDRGradeWidgetHistogramMode>1</HDRGradeWidgetHistogramMode>
      <HDRGradeChromaDisplayType>0</HDRGradeChromaDisplayType>
      <DefaultPreset>None</DefaultPreset>
      <DefaultHueResolution>6</DefaultHueResolution>
      <DefaultSaturationResolution>6</DefaultSaturationResolution>
      <DefaultChromaResolution>6</DefaultChromaResolution>
      <DefaultLumaResolution>6</DefaultLumaResolution>
      <IsBankHDRGlobalWithColorWheels>false</IsBankHDRGlobalWithColorWheels>
      <ShowOfflineThroughConformGaps>false</ShowOfflineThroughConformGaps>
      <ShowOfflineThroughMissingMedia>false</ShowOfflineThroughMissingMedia>
      <ColorPickerType>Resolve</ColorPickerType>
      <PlayPriority>false</PlayPriority>
      <WipeWrap>true</WipeWrap>
      <GraphNodeHighLightMode>0</GraphNodeHighLightMode>
      <ImpresarioColorScheme>
        <SM_ImpresarioScheme DbId="3cab6221-e9b0-4925-9736-8a03b02114cc">
        <FieldsBlob/>
        <LCDBaseR>100</LCDBaseR>
        <LCDBaseG>100</LCDBaseG>
        <LCDBaseB>100</LCDBaseB>
        <LCDLastControlR>100</LCDLastControlR>
        <LCDLastControlG>100</LCDLastControlG>
        <LCDLastControlB>0</LCDLastControlB>
        <LCDNonDefaultR>0</LCDNonDefaultR>
        <LCDNonDefaultG>100</LCDNonDefaultG>
        <LCDNonDefaultB>100</LCDNonDefaultB>
        <LCDOverlayR>100</LCDOverlayR>
        <LCDOverlayG>0</LCDOverlayG>
        <LCDOverlayB>0</LCDOverlayB>
        <LEDBaseR>50</LEDBaseR>
        <LEDBaseG>0</LEDBaseG>
        <LEDBaseB>0</LEDBaseB>
        <LEDLastControlR>50</LEDLastControlR>
        <LEDLastControlG>50</LEDLastControlG>
        <LEDLastControlB>0</LEDLastControlB>
        <LEDHighlightR>0</LEDHighlightR>
        <LEDHighlightG>50</LEDHighlightG>
        <LEDHighlightB>50</LEDHighlightB>
        </SM_ImpresarioScheme>
      </ImpresarioColorScheme>
      <ImpresarioLCDBrightness>10</ImpresarioLCDBrightness>
      <AutoCueMediaPool>false</AutoCueMediaPool>
      <AutoCueMasterSession>false</AutoCueMasterSession>
      <NeighborClipsInSplitScreen>3</NeighborClipsInSplitScreen>
      <MasterResetMode>false</MasterResetMode>
      <HighVisibilityPowerWindowOutlines>false</HighVisibilityPowerWindowOutlines>
      <PanelRippleMode>0</PanelRippleMode>
      <DeliverableSetup>
        <SM_DeliverableSetup DbId="ca38e52a-af93-43b4-9c91-c95067009cad">
        <FieldsBlob/>
        <PLLabAimY>25</PLLabAimY>
        <PLLabAimR>25</PLLabAimR>
        <PLLabAimG>25</PLLabAimG>
        <PLLabAimB>25</PLLabAimB>
        <PLDensityY>1</PLDensityY>
        <PLDensityR>1</PLDensityR>
        <PLDensityG>1</PLDensityG>
        <PLDensityB>1</PLDensityB>
        <PLStepsY>1</PLStepsY>
        <PLStepsR>1</PLStepsR>
        <PLStepsG>1</PLStepsG>
        <PLStepsB>1</PLStepsB>
        </SM_DeliverableSetup>
      </DeliverableSetup>
      <KeyboardMappings>0</KeyboardMappings>
      <CustomKeyboardPreset/>
      <StandardTransitionLengthType>TRANSITION_LENGTH_IN_SECONDS</StandardTransitionLengthType>
      <StandardTransitionDuration>1</StandardTransitionDuration>
      <StandardTransitionLength>20</StandardTransitionLength>
      <GeneratorDurationType>DURATION_IN_SECONDS</GeneratorDurationType>
      <GeneratorDurationSecs>5</GeneratorDurationSecs>
      <GeneratorDurationFrames>125</GeneratorDurationFrames>
      <StillDurationType>DURATION_IN_SECONDS</StillDurationType>
      <StillDurationSecs>5</StillDurationSecs>
      <StillDurationFrames>125</StillDurationFrames>
      <PreRollDurationType>DURATION_IN_SECONDS</PreRollDurationType>
      <PreRollDurationSecs>2</PreRollDurationSecs>
      <PreRollDurationFrames>20</PreRollDurationFrames>
      <PostRollDurationType>DURATION_IN_SECONDS</PostRollDurationType>
      <PostRollDurationSecs>2</PostRollDurationSecs>
      <PostRollDurationFrames>20</PostRollDurationFrames>
      <NumberOfVideoTracks>1</NumberOfVideoTracks>
      <NumberOfAudioTracks>1</NumberOfAudioTracks>
      <AudioTrackType>0</AudioTrackType>
      <StartTimecode>01:00:00:00</StartTimecode>
      <PerfModeType>PERF_MODE_AUTOMATIC</PerfModeType>
      <PerfModeOptSizing>true</PerfModeOptSizing>
      <PerfModeOptDecode>true</PerfModeOptDecode>
      <PerfModeOptImgProcessing>true</PerfModeOptImgProcessing>
      <CurrentSoundLibraryDb>Local Database</CurrentSoundLibraryDb>
      <IsUnmixMode>false</IsUnmixMode>
      <FusionMemoryCacheMode>FUSION_MEMORY_CACHE_MODE_AUTO</FusionMemoryCacheMode>
      <PlaybackLoopMode>0</PlaybackLoopMode>
      <IsLinkedMoveAcrossTracks>true</IsLinkedMoveAcrossTracks>
      <UseLablesOnStillExport>false</UseLablesOnStillExport>
      <ShowClipFlagsOnVideoOutput>false</ShowClipFlagsOnVideoOutput>
      <IsBoringDetectorEnabled>false</IsBoringDetectorEnabled>
      <BoringClipsTime>45</BoringClipsTime>
      <JumpCutsTime>5</JumpCutsTime>
      <IsVideoTracksEnabled>false</IsVideoTracksEnabled>
      <IsInFixedPlayheadMode>false</IsInFixedPlayheadMode>
      <FairlightPlayheadMode>0</FairlightPlayheadMode>
      <IsVideoScrollerEnabled>false</IsVideoScrollerEnabled>
      <IsAudioScroller1Enabled>false</IsAudioScroller1Enabled>
      <IsAudioScroller2Enabled>false</IsAudioScroller2Enabled>
      <IsShowFullAudioWaveform>false</IsShowFullAudioWaveform>
      <IsShowAudioWaveformBorders>true</IsShowAudioWaveformBorders>
      <IsSelectionFollowsPlayhead>false</IsSelectionFollowsPlayhead>
      <IsAlignAudioEditsToFrameBoundaries>false</IsAlignAudioEditsToFrameBoundaries>
      <IsLimitAudioSyncToFirstTimecodeMatch>false</IsLimitAudioSyncToFirstTimecodeMatch>
      <IsImportFinderTagsAsKeywords>false</IsImportFinderTagsAsKeywords>
      <PlayerPreviewMode>1</PlayerPreviewMode>
      <IsShowIndividualFrames>false</IsShowIndividualFrames>
      <FrameDisplayMode>0</FrameDisplayMode>
      <VectorScopeScaleStyle>1</VectorScopeScaleStyle>
      <VectorScopeScaleTargetType>1</VectorScopeScaleTargetType>
      <ShowVectorScopeScaleLabels>true</ShowVectorScopeScaleLabels>
      <TimelineSortOrder>2</TimelineSortOrder>
      <IsZoomAroundMousePointerEnabled>false</IsZoomAroundMousePointerEnabled>
      <IsAutoReleaseLocksOnIdleEnabled>true</IsAutoReleaseLocksOnIdleEnabled>
      <AutoReleaseLocksOnIdleTimeoutMins>5</AutoReleaseLocksOnIdleTimeoutMins>
      <Is2DTimelineScrollEnabled>true</Is2DTimelineScrollEnabled>
      <ShowPlayheadShadow>false</ShowPlayheadShadow>
      <DisplayScale>100</DisplayScale>
      </SM_UserPrefs>
    '';
  };
}
