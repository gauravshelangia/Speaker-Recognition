files = dir('Train/*.wav');

files(1).name;

nfile = size(files);

num = nfile(1)
for n = 1:num
	name = files(n).name
end
