unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    CheckBox1: TCheckBox;
    Button1: TButton;
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses MasterVolume;

{$R *.dfm}



procedure TForm1.Button1Click(Sender: TObject);
begin
  caption := 'MUTE=' + BoolToStr(MasterVolume.isMasterVolumeMute(),True);
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  MasterVolume.doMasterVolumeMute(CheckBox1.Checked);
end;

end.
