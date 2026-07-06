function d = UpdateCheckmark_C2S(d, tag, value)

d.GUI.checkmarks.values.(tag) = value;

if value == 0
    color = 'red';
elseif value == 1
    color =  [0.51 0.70 0.54];
end

set(d.GUI.checkmarks.graphics.(tag), 'ForegroundColor', color);