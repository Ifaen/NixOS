{user, ...}: {
  user.manage.xdg.configFile."obs-studio/basic/profiles/Untitled/basic.ini" = {
    force = true;
    text = ''
      [General]
      Name=Untitled

      [Output]
      Mode=Simple
      FilenameFormatting=%CCYY-%MM-%DD %hh-%mm-%ss
      DelayEnable=false
      DelaySec=20
      DelayPreserve=true
      Reconnect=true
      RetryDelay=2
      MaxRetries=25
      BindIP=default
      IPFamily=IPv4+IPv6
      NewSocketLoopEnable=false
      LowLatencyEnable=false

      [Stream1]
      IgnoreRecommended=false

      [SimpleOutput]
      FilePath=${user.dir.recordings}
      RecFormat2=mkv
      VBitrate=2500
      ABitrate=160
      UseAdvanced=false
      Preset=veryfast
      NVENCPreset2=p5
      RecQuality=Small
      RecRB=false
      RecRBTime=20
      RecRBSize=512
      RecRBPrefix=Replay
      StreamAudioEncoder=aac
      RecAudioEncoder=aac
      RecTracks=1
      StreamEncoder=x264
      RecEncoder=x264

      [AdvOut]
      ApplyServiceSettings=true
      UseRescale=false
      TrackIndex=1
      VodTrackIndex=2
      Encoder=obs_x264
      RecType=Standard
      RecFilePath=${user.home}
      RecFormat2=mkv
      RecUseRescale=false
      RecTracks=1
      RecEncoder=none
      FLVTrack=1
      StreamMultiTrackAudioMixes=1
      FFOutputToFile=true
      FFFilePath=${user.home}
      FFExtension=mp4
      FFVBitrate=2500
      FFVGOPSize=250
      FFUseRescale=false
      FFIgnoreCompat=false
      FFABitrate=160
      FFAudioMixes=1
      Track1Bitrate=160
      Track2Bitrate=160
      Track3Bitrate=160
      Track4Bitrate=160
      Track5Bitrate=160
      Track6Bitrate=160
      RecSplitFileTime=15
      RecSplitFileSize=2048
      RecRB=false
      RecRBTime=20
      RecRBSize=512
      AudioEncoder=libfdk_aac
      RecAudioEncoder=libfdk_aac

      [Video]
      BaseCX=1360
      BaseCY=768
      OutputCX=1360
      OutputCY=768
      FPSType=0
      FPSCommon=60
      FPSInt=30
      FPSNum=30
      FPSDen=1
      ScaleType=bicubic
      ColorFormat=NV12
      ColorSpace=709
      ColorRange=Partial
      SdrWhiteLevel=300
      HdrNominalPeakLevel=1000

      [Audio]
      MonitoringDeviceId=default
      MonitoringDeviceName=Default
      SampleRate=48000
      ChannelSetup=Stereo
      MeterDecayRate=23.53
      PeakMeterType=0
    '';
  };
}
