function UISet_C2S(UIHandle, varargin)

if nargin ~= 3
    return;
end

set(UIHandle, varargin{1}, varargin{2});

