
clc; clear; close all;

image_folder = 'data uji';
filenames ='Ak47-01.jpg' ;
total_images = numel(filenames);

data_uji = zeros(6,total_images);

for n = 1:total_images
    full_name= fullfile(image_folder, filenames);
    Img = imread(full_name);
    Img = im2double(Img);
    
    
    % Ekstraksi Ciri Warna RGB
    R = Img(:,:,1);
    G = Img(:,:,2);
    B = Img(:,:,3);
    RGB = cat(3,R,G,B);
    
    CiriR = mean2(R);
    CiriG = mean2(G);
    CiriB = mean2(B);
    CiriRGB=mean2(RGB);
    
    
    
    % Pembentukan data uji
    data_uji(1,n) = CiriR;
    data_uji(2,n) = CiriG;
    data_uji(3,n) = CiriB;
    data_uji(4,n) = CiriRGB;

end

% Pembentukan target uji
target_uji = ones(1,total_images);
target_uji(1:total_images/2) = 0;

load net_keluaran
hasil_uji = round(sim(net_keluaran,data_uji));

[m,n] = find(hasil_uji==target_uji);
akurasi = sum(m)/total_images*100;
    
    if hasil_uji == 0
        kelas = 'AK47';
    elseif hasil_uji == 1
        kelas = 'Corner Shot';
    else
        kelas = 'Unknown';
    end
    
    akurasi
    kelas
