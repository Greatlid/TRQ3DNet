function arr_norm = normalized(array)
amin = min(array(:));
amax = max(array(:));
arr_norm = (array - amin) / (amax - amin);

end