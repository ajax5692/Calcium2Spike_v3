function UpdateProgressbar(d, progressbarType, colorValRGB, frac)

childrenArray = GUI_childrenFinder_C2S(d,'',progressbarType);


frac = max(0, min(1, frac));
set(d.source.Children(childrenArray).Children, 'XData', [0 0 frac frac], 'FaceColor', colorValRGB);
