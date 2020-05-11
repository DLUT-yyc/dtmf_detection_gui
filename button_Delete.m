global tone_all;
L = length(tone_all)/1421
tone_all = tone_all(1:(L-1)*1421);
L = length(keyNames)
keyNames = keyNames(1:L-1);
set(Display,'String',keyNames);