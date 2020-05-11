close all;clear;clc;
%% Main 
global keyNames tone_all h1 h2 h3 h4 Decode_output File_Decode_output
keyNames=[];
tone_all=[];
Decode_output=[];
File_Decode_output=[];

h1=subplot(2,3,2);grid on;
title('时域图');
ylabel('Amplitude');
xlabel('time (second)');
axis([0 0.035 -2 2]);

h2=subplot(2,3,3);grid on;
title('频域图');
ylabel('Amplitude');
xlabel('frequency (Hz)');
axis([500 2000 0 1]);

h3=subplot(2,3,5);grid on;
title('峰值图');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
axis([500 2000 0 1]);

h4=subplot(2,3,6);grid on;
title('解码频域图');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
axis([500 2000 0 1]);

%% UI
set(gcf,'Units','centimeters','position',[1 2 49 24],'Name','DTMF_SYSTEM'); % UI Window Position

bip=[100,600]; 
bs=60;

AuthorDisplay=uicontrol('Style', 'text', 'Position',[bip+[0 bs*4],220,35],'String', '电信1803 袁亦忱','FontSize',20,'HorizontalAlignment','left','BackgroundColor',[0.937 0.867 0.867]);

NotesDisplay=uicontrol('Style', 'text', 'Position',[bip+[0 bs*2.2],300,80],'String', '注意:（1）先拨号再解码                                               （2）不可以拨空号                                               （3）删除键单独设置，不是*                                 （4）拨号后不可删除','FontSize',10,'HorizontalAlignment','left','BackgroundColor',[0.839 0.91 0.851]);

InputDisplay=uicontrol('Style', 'text', 'Position',[bip+[0 bs*1.5],85,35],'String', '输入: ','FontSize',20,'HorizontalAlignment','left','BackgroundColor',[0.839 0.91 0.851]);

Display=uicontrol('Style', 'text', 'Position',[bip+[0 bs*1],385,35],'String', 'KeyNames','FontSize',20,'HorizontalAlignment','left','FontSize',20,'BackgroundColor',[0.973 0.973 0.973]);
set(Display,'String',keyNames);

button1 = uicontrol;
set(button1,'String','1','Position',[bip,repmat(bs,1,2)],'FontSize',20,'BackgroundColor',[0.804 0.878 0.969]); 
set(button1,'Callback','button_1');

button2 = uicontrol;
set(button2,'String','2','Position',[bip+[bs*1 0],repmat(bs,1,2)],'FontSize',20,'BackgroundColor',[0.804 0.878 0.969]); 
set(button2,'Callback','button_2');

button3 = uicontrol; 
set(button3,'String','3','Position',[bip+[bs*2 0],repmat(bs,1,2)],'FontSize',20,'BackgroundColor',[0.804 0.878 0.969]);
set(button3,'Callback','button_3');

buttonA = uicontrol;
set(buttonA,'String','A','Position',[bip+[bs*3 0],repmat(bs,1,2)],'FontSize',20,'BackgroundColor',[0.804 0.878 0.969]); 
set(buttonA,'Callback','button_A'); 

button4 = uicontrol;
set(button4,'String','4','Position',[bip+[0 -bs*1],repmat(bs,1,2)],'FontSize',20,'BackgroundColor',[0.804 0.878 0.969]);
set(button4,'Callback','button_4');

button5 = uicontrol; 
set(button5,'String','5','Position',[bip+[bs*1 -bs*1],repmat(bs,1,2)],'FontSize',20,'BackgroundColor',[0.804 0.878 0.969]); 
set(button5,'Callback','button_5');

button6 = uicontrol;
set(button6,'String','6','Position',[bip+[bs*2 -bs*1],repmat(bs,1,2)],'FontSize',20,'BackgroundColor',[0.804 0.878 0.969]);
set(button6,'Callback','button_6');

buttonB = uicontrol;
set(buttonB,'String','B','Position',[bip+[bs*3 -bs*1],repmat(bs,1,2)],'FontSize',20,'BackgroundColor',[0.804 0.878 0.969]); 
set(buttonB,'Callback','button_B'); 

button7 = uicontrol; 
set(button7,'String','7','Position',[bip+[0 -bs*2],repmat(bs,1,2)],'FontSize',20,'BackgroundColor',[0.804 0.878 0.969]); 
set(button7,'Callback','button_7'); 

button8 = uicontrol; 
set(button8,'String','8','Position',[bip+[bs*1 -bs*2],repmat(bs,1,2)],'FontSize',20,'BackgroundColor',[0.804 0.878 0.969]);
set(button8,'Callback','button_8');

button9 = uicontrol;
set(button9,'String','9','Position',[bip+[bs*2 -bs*2],repmat(bs,1,2)],'FontSize',20,'BackgroundColor',[0.804 0.878 0.969]); 
set(button9,'Callback','button_9');

buttonC = uicontrol; 
set(buttonC,'String','C','Position',[bip+[bs*3 -bs*2],repmat(bs,1,2)],'FontSize',20,'BackgroundColor',[0.804 0.878 0.969]); 
set(buttonC,'Callback','button_C'); 

buttonStar = uicontrol;
set(buttonStar,'String','*','Position',[bip+[0 -bs*3],repmat(bs,1,2)],'FontSize',20,'BackgroundColor',[0.804 0.878 0.969]);
set(buttonStar,'Callback','button_Star');

button0 = uicontrol; 
set(button0,'String','0','Position',[bip+[bs*1 -bs*3],repmat(bs,1,2)],'FontSize',20,'BackgroundColor',[0.804 0.878 0.969]); 
set(button0,'Callback','button_0'); 

buttonSign = uicontrol;
set(buttonSign,'String','#','Position',[bip+[bs*2 -bs*3],repmat(bs,1,2)],'FontSize',20,'BackgroundColor',[0.804 0.878 0.969]); 
set(buttonSign,'Callback','button_Sign'); 

buttonD = uicontrol;
set(buttonD,'String','D','Position',[bip+[bs*3 -bs*3],repmat(bs,1,2)],'FontSize',20,'BackgroundColor',[0.804 0.878 0.969]); 
set(buttonD,'Callback','button_D');

buttonRecord = uicontrol;
set(buttonRecord,'String','拨号','Position',[bip+[0 -bs*3.5],bs*4,bs/2],'FontSize',20,'BackgroundColor',[0.839 0.91 0.851]);
set(buttonRecord,'Callback','button_Record');

buttonDelete = uicontrol;
set(buttonDelete,'String','删除','Position',[bip+[0 -bs*4],bs*4,bs/2],'FontSize',20,'BackgroundColor',[0.439 0.51 0.851]); 
set(buttonDelete,'Callback','button_Delete');

buttonClear = uicontrol;
set(buttonClear,'String','全部清除','Position',[bip+[0 -bs*4.5],bs*4,bs/2],'FontSize',20,'BackgroundColor',[0.937 0.867 0.867]); 
set(buttonClear,'Callback','button_Clear'); 

buttonDecode = uicontrol; 
set(buttonDecode,'String','解码','Position',[bip+[0 -bs*5],bs*4,bs/2],'FontSize',20,'BackgroundColor',[0.992 0.918 0.796]); 
set(buttonDecode,'Callback','button_Decode');

buttonFileDecode = uicontrol; 
set(buttonFileDecode,'String','音频文件解码','Position',[bip+[0 -bs*5.5],bs*4,bs/2],'FontSize',20,'BackgroundColor',[0.592 0.518 0.796]); 
set(buttonFileDecode,'Callback','button_FileDecode'); 

DecodeDisplay=uicontrol('Style', 'text', 'Position',[bip+[0 -bs*6.5],250,35],'String', '输入解码结果: ','FontSize',15,'HorizontalAlignment','left','BackgroundColor',[0.839 0.91 0.851]);

Display2=uicontrol('Style', 'text', 'Position',[bip+[0 -bs*7],385,35],'String', 'KeyNames','FontSize',15,'HorizontalAlignment','left','FontSize',20,'BackgroundColor',[0.973 0.973 0.973]);
set(Display2,'String',Decode_output);

DecodeDisplay=uicontrol('Style', 'text', 'Position',[bip+[0 -bs*8],250,35],'String', '音频文件解码结果: ','FontSize',15,'HorizontalAlignment','left','BackgroundColor',[0.839 0.91 0.851]);

Display3=uicontrol('Style', 'text', 'Position',[bip+[0 -bs*8.5],385,35],'String', 'KeyNames','FontSize',15,'HorizontalAlignment','left','FontSize',20,'BackgroundColor',[0.973 0.973 0.973]);
set(Display3,'String',File_Decode_output); 