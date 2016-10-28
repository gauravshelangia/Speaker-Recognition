function code = train(train, n)
% Speaker Recognition: Training Stage
%
% Input:
%       traindir : string name of directory contains all train sound files
%       n        : number of train files in traindir
%
% Output:
%       code     : trained VQ codebooks, code{i} for i-th speaker
%
% Note:
%       Sound files in traindir is supposed to be: 
%                       s1.wav, s2.wav, ..., sn.wav
% Example:
%       >> code = train('C:\data\train\', 8);

k = 16;                         % number of centroids required
%n=8;
R = [300 4000];
files = dir('traindata/*.wav');
for i = 1:n                     % train a VQ codebook for each speaker
    %file = sprintf('s%d.wav',i);           
    %disp(file);    
    file = files(i).name;
    file1 = strcat('traindata/',file);
    %disp(file1);
        
    [s, fs] = audioread(file1);
   
    N=20;
    h = (0.54-0.46*cos(2*pi*[0:N-1].'/(N-1)));
    
    v = mfcc(s, fs,12,4,0.97,h,R,20,N,22 );            % Compute MFCC's
    %figure(i)
    %plot(v);
    %disp(size(v));
    
    code{i} = vqlbg(v,k);      % Train VQ codebook
    %disp(code{i});
end
filest = dir('test/*.wav');
a = size(filest);

    test('test',a(1),code);

