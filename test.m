function test(testdir, n, code)
% Speaker Recognition: Testing Stage
%
% Input:
%       testdir : string name of directory contains all test sound files
%       n       : number of test files in testdir
%       code    : codebooks of all trained speakers
%
% Note:
%       Sound files in testdir is supposed to be: 
%               s1.wav, s2.wav, ..., sn.wav
%
% Example:
%       >> test('C:\data\test\', 8, code);
R = [300 4000];
N=20;
files1 = dir('traindata/*.wav');
files2 = dir('test/*.wav');
threshold=15;
for k = 1:n                     % read test sound file of each speaker

    %file = sprintf('s%d.wav',k);
    file = files2(k).name;
    file2 = strcat('test/',file);
    [s, fs] = audioread(file2);     
    
    h = (0.54-0.46*cos(2*pi*[0:N-1].'/(N-1)));
    
    v = mfcc(s, fs,12,4,0.97,h,R,20,N,22 );            % Compute MFCC's

    distmin = inf;
    
    k1 = 0;
   
    for l = 1:length(code)      % each trained codebook, compute distortion
        d = disteu(v, code{l}); 
        dist = sum(min(d,[],2)) / size(d,1);
      
        if dist < distmin
            distmin = dist;
            k1 = l;
    
        end 
        
    end
    k1
        s1=files2(k).name;
        s2=files1(k1).name;
        ns = size(s1);
        s1 = s1(: ,[1:ns(2)-4]);
        
        ns=size(s2);
        s2 = s2(: ,[1: ns(2)-4]);
        
       
    if distmin>threshold 
        msg  = sprintf('Speaker %s doesnot match to anyone',s1);
         distmin
    else
        
        msg = sprintf('Speaker %s  matches with speaker %s', s1, s2);
        distmin
    end
    disp(msg);
end
