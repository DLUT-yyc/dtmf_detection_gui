global File_Decode_output
[file,path] = uigetfile('*.m4a');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
    [x,fs]=audioread(fullfile(path,file));
    Peak_value=[];
    Indexes=[];
    File_Decode_output = [];
    t=[0:length(x)-1]/fs;   
    
    [pks,locs] = findpeaks(x,t,'MinPeakHeight',0.06,'MinPeakDistance',0.4);
%     [pks,locs] = findpeaks(pks,locs,'MinPeakDistance',0.4);

    h1=subplot(2,3,2);plot(t,x);grid on;
    title('时域图');
    ylabel('Amplitude');
    xlabel('time (second)');

    t2=[0:length(pks)-1]/fs;   
    h3=subplot(2,3,5);plot(locs,pks,'-o');grid on;
    title('过滤后的信号峰值图');
    ylabel('Amplitude2');
    xlabel('time2 (second)');
    for ii=1:length(locs)
        Indexes = [Indexes find(t == locs(ii))];
        Peak_value = [Peak_value;x(Indexes(ii):Indexes(ii)+999)];
    end
    for i=1:length(Peak_value)/1000
        f=fft(Peak_value(i*1000-999:i*1000),fs);
        a=abs(f);
        p=a.*a/fs;
        num(1)=find(p(1:1000)==max(p(1:1000)));
        num(2)=1000+find(p(1000:1700)==max(p(1000:1700)));
        if(num(1) < 730)
            row=1;
        elseif (num(1) < 810)
            row=2;
        elseif (num(1) < 900)
            row=3;
        else
            row=4;
        end
        if(num(2) < 1270)
            line=1;
        elseif (num(2) < 1400)
            line=2;
        elseif (num(2) < 1600)
            line=3;
        else
            line=4;
        end
        switch row
            case {1}
                switch line
                    case {1}
                        File_Decode_output=strcat(File_Decode_output,'1');
                    case {2}
                        File_Decode_output=[File_Decode_output,'2'];
                    case {3}
                        File_Decode_output=[File_Decode_output,'3'];
                    case {4}
                        File_Decode_output=[File_Decode_output,'A'];
                end
            case {2}
                switch line
                    case {1}
                        File_Decode_output=[File_Decode_output,'4'];
                    case {2}
                        File_Decode_output=[File_Decode_output,'5'];
                    case {3}
                        File_Decode_output=[File_Decode_output,'6'];
                    case {4}
                        File_Decode_output=[File_Decode_output,'B'];
                end
            case {3}
                switch line
                    case {1}
                        File_Decode_output=[File_Decode_output,'7'];
                    case {2}
                        File_Decode_output=[File_Decode_output,'8'];
                    case {3}
                        File_Decode_output=[File_Decode_output,'9'];
                    case {4}
                        File_Decode_output=[File_Decode_output,'C'];
                end
            case {4}
                switch line
                    case {1}
                        File_Decode_output=[File_Decode_output,'*'];
                    case {2}
                        File_Decode_output=[File_Decode_output,'0'];
                    case {3}
                        File_Decode_output=[File_Decode_output,'#'];
                    case {4}
                        File_Decode_output=[File_Decode_output,'D'];
                end
        end
    end
    set(Display3,'String',File_Decode_output); 
%     File_Decode_output

end

