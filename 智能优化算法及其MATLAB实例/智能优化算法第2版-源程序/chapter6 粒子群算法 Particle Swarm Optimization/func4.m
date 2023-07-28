%%%%%%%%%%%%%%%%%%ÊÊÓ¦¶Èº¯Êý%%%%%%%%%%%%%%%%%
function result = func4(f,C,W,V,afa)
fit = sum(f.*W);
TotalSize = sum(f.*C);
if TotalSize <= V
    fit = fit;
else
    fit = fit - afa * (TotalSize - V);
end
result = fit;