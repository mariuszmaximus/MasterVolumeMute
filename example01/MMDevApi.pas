unit MMDevApi;

interface

uses
  Windows, ActiveX, ComObj;

const
  CLSID_MMDeviceEnumerator : TGUID = '{BCDE0395-E52F-467C-8E3D-C4579291692E}';
  IID_IMMDeviceEnumerator : TGUID = '{A95664D2-9614-4F35-A746-DE8DB63617E6}';
  IID_IMMDevice : TGUID = '{D666063F-1587-4E43-81F1-B948E807363F}';
  IID_IMMDeviceCollection : TGUID = '{0BD7A1BE-7A1A-44DB-8397-CC5392387B5E}';
  IID_IAudioEndpointVolume : TGUID = '{5CDF2C82-841E-4546-9722-0CF74078229A}';
  IID_IAudioMeterInformation : TGUID = '{C02216F6-8C67-4B5B-9D00-D008E73E0064}';
  IID_IAudioEndpointVolumeCallback : TGUID = '{657804FA-D6AD-4496-8A60-352752AF4F89}';
  IID_IMMNotificationClient : TGUID = '{7991EEC9-7E89-4D85-8390-6C703CEC60C0}';

  DEVICE_STATE_ACTIVE = $00000001;
  DEVICE_STATE_UNPLUGGED = $00000002;
  DEVICE_STATE_NOTPRESENT = $00000004;
  DEVICE_STATEMASK_ALL = $00000007;

type
 PAUDIO_VOLUME_NOTIFICATION_DATA = ^AUDIO_VOLUME_NOTIFICATION_DATA;
 AUDIO_VOLUME_NOTIFICATION_DATA = packed record
  guidEventContext: TGUID;
  bMuted: BOOL;
  fMasterVolume: Single;
  nChannels: UINT;
  afChannelVolumes: array[1..1] of Single;
 end;

type
  EDataFlow = TOleEnum;

const
  eRender = $00000000;
  eCapture = $00000001;
  eAll = $00000002;
  EDataFlow_enum_count = $00000003;

type
  ERole = TOleEnum;

const
  eConsole = $00000000;
  eMultimedia = $00000001;
  eCommunications = $00000002;
  ERole_enum_count = $00000003;

type
  IAudioEndpointVolumeCallback = interface(IUnknown)
  [IID_IAudioEndpointVolumeCallback]
    function OnNotify(pNotify: PAUDIO_VOLUME_NOTIFICATION_DATA): HRESULT; stdcall;
  end;

  IAudioEndpointVolume = interface(IUnknown)
  [IID_IAudioEndpointVolume]
    function RegisterControlChangeNotify(AudioEndPtVol: IAudioEndpointVolumeCallback): Integer; stdcall;
    function UnregisterControlChangeNotify(AudioEndPtVol: IAudioEndpointVolumeCallback): Integer; stdcall;
    function GetChannelCount(out PInteger): Integer; stdcall;
    function SetMasterVolumeLevel(fLevelDB: single; pguidEventContext: PGUID): Integer; stdcall;
    function SetMasterVolumeLevelScalar(fLevelDB: single; pguidEventContext: PGUID): Integer; stdcall;
    function GetMasterVolumeLevel(out fLevelDB: single): Integer; stdcall;
    function GetMasterVolumeLevelScaler(out fLevelDB: single): Integer; stdcall;
    function SetChannelVolumeLevel(nChannel: Integer; fLevelDB: double; pguidEventContext: PGUID): Integer; stdcall;
    function SetChannelVolumeLevelScalar(nChannel: Integer; fLevelDB: double; pguidEventContext: PGUID): Integer; stdcall;
    function GetChannelVolumeLevel(nChannel: Integer; out fLevelDB: double): Integer; stdcall;
    function GetChannelVolumeLevelScalar(nChannel: Integer; out fLevel: double): Integer; stdcall;
    function SetMute(bMute: Boolean; pguidEventContext: PGUID): Integer; stdcall;
    function GetMute(out bMute: Boolean): Integer; stdcall;
    function GetVolumeStepInfo(pnStep: Integer; out pnStepCount: Integer): Integer; stdcall;
    function VolumeStepUp(pguidEventContext: PGUID): Integer; stdcall;
    function VolumeStepDown(pguidEventContext: PGUID): Integer; stdcall;
    function QueryHardwareSupport(out pdwHardwareSupportMask): Integer; stdcall;
    function GetVolumeRange(out pflVolumeMindB: double; out pflVolumeMaxdB: double; out pflVolumeIncrementdB: double): Integer; stdcall;
  end;

  IAudioMeterInformation = interface(IUnknown)
  [IID_IAudioMeterInformation]
    function GetPeakValue(out Peak: Real): HRESULT; stdcall;
  end;

  IPropertyStore = interface(IUnknown)
  end;

  IMMDevice = interface(IUnknown)
  [IID_IMMDevice]
    function Activate(const refId: TGUID; dwClsCtx: DWORD; pActivationParams: PInteger; out pEndpointVolume: IAudioEndpointVolume): HRESULT; stdCall;
    function OpenPropertyStore(stgmAccess: DWORD; out ppProperties: IPropertyStore): HRESULT; stdcall;
    function GetId(out ppstrId: PLPWSTR): HRESULT; stdcall;
    function GetState(out State: Integer): HRESULT; stdcall;
  end;

  IMMDeviceCollection = interface(IUnknown)
  [IID_IMMDeviceCollection]
    function GetCount(out pcDevices: UINT): HRESULT; stdcall;
    function Item(nDevice: UINT; out ppDevice: IMMDevice): HRESULT; stdcall;
  end;

  IMMNotificationClient = interface(IUnknown)
  [IID_IMMNotificationClient]
  end;

  IMMDeviceEnumerator = interface(IUnknown)
  [IID_IMMDeviceEnumerator]
    function EnumAudioEndpoints(dataFlow: EDataFlow; deviceState: SYSUINT; out DevCollection: IMMDeviceCollection): HRESULT; stdcall;
    function GetDefaultAudioEndpoint(EDF: SYSUINT; ER: SYSUINT; out Dev: IMMDevice): HRESULT; stdcall;
    function GetDevice(pwstrId: pointer; out Dev: IMMDevice): HRESULT; stdcall;
    function RegisterEndpointNotificationCallback(pClient: IMMNotificationClient): HRESULT; stdcall;
    function UnregisterEndpointNotificationCallback(pClient: IMMNotificationClient): HRESULT; stdcall;
  end;

implementation

end.