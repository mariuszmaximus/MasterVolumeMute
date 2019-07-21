unit MasterVolume;

interface

uses Windows,  ActiveX, ComObj, Dialogs, SysUtils;

procedure doMasterVolumeMute(bMute: Boolean);
function isMasterVolumeMute: boolean;


implementation

uses MMDevApi;

procedure doMasterVolumeMute(bMute: Boolean);
var
  MMDeviceCollection: IMMDeviceCollection;
  MMDeviceEnumerator: IMMDeviceEnumerator;
  device :IMMDevice ;
  hr: HRESULT;
  deviceCount : UINT;
  i : integer;
  endpointVolume: IAudioEndpointVolume;
begin
  hr := CoCreateInstance(CLSID_MMDeviceEnumerator, nil, CLSCTX_ALL, IID_IMMDeviceEnumerator, MMDeviceEnumerator);
  if hr <> ERROR_SUCCESS then ShowMessage(SysErrorMessage(hr));

  MMDeviceCollection := nil; // wegen dem OUT-Parameter *1
  hr := MMDeviceEnumerator.EnumAudioEndpoints(eRender, DEVICE_STATE_ACTIVE, MMDeviceCollection);
  if hr <> ERROR_SUCCESS then ShowMessage(SysErrorMessage(hr));

  hr := MMDeviceCollection.GetCount(deviceCount);
  if hr <> ERROR_SUCCESS then ShowMessage(SysErrorMessage(hr));

  for i:=0 to deviceCount-1 do
  begin
    MMDeviceCollection.Item(i, device);
    endpointVolume:=nil;
    device.Activate(IID_IAudioEndpointVolume, CLSCTX_INPROC_SERVER, nil, endpointVolume);
    endpointVolume.SetMute(bMute,nil);
  end;
end;


function isMasterVolumeMute: boolean;
var
  MMDeviceCollection: IMMDeviceCollection;
  MMDeviceEnumerator: IMMDeviceEnumerator;
  device :IMMDevice ;
  hr: HRESULT;
  deviceCount : UINT;
  i : integer;
  endpointVolume: IAudioEndpointVolume;
  bMute: Boolean;
begin
  result := True;

  hr := CoCreateInstance(CLSID_MMDeviceEnumerator, nil, CLSCTX_ALL, IID_IMMDeviceEnumerator, MMDeviceEnumerator);
  if hr <> ERROR_SUCCESS then ShowMessage(SysErrorMessage(hr));

  MMDeviceCollection := nil; // wegen dem OUT-Parameter *1
  hr := MMDeviceEnumerator.EnumAudioEndpoints(eRender, DEVICE_STATE_ACTIVE, MMDeviceCollection);
  if hr <> ERROR_SUCCESS then ShowMessage(SysErrorMessage(hr));

  hr := MMDeviceCollection.GetCount(deviceCount);
  if hr <> ERROR_SUCCESS then ShowMessage(SysErrorMessage(hr));

  for i:=0 to deviceCount-1 do
  begin
    MMDeviceCollection.Item(i, device);
    endpointVolume:=nil;
    device.Activate(IID_IAudioEndpointVolume, CLSCTX_INPROC_SERVER, nil, endpointVolume);
    endpointVolume.GetMute(bMute);
    result := result and bMute;
  end;
end;



end.
