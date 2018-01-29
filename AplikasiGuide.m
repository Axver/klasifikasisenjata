function varargout = AplikasiGuide(varargin)
% APLIKASIGUIDE MATLAB code for AplikasiGuide.fig
%      APLIKASIGUIDE, by itself, creates a new APLIKASIGUIDE or raises the existing
%      singleton*.
%
%      H = APLIKASIGUIDE returns the handle to a new APLIKASIGUIDE or the handle to
%      the existing singleton*.
%
%      APLIKASIGUIDE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APLIKASIGUIDE.M with the given input arguments.
%
%      APLIKASIGUIDE('Property','Value',...) creates a new APLIKASIGUIDE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AplikasiGuide_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AplikasiGuide_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AplikasiGuide

% Last Modified by GUIDE v2.5 20-Nov-2017 15:06:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AplikasiGuide_OpeningFcn, ...
                   'gui_OutputFcn',  @AplikasiGuide_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before AplikasiGuide is made visible.
function AplikasiGuide_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AplikasiGuide (see VARARGIN)

% Choose default command line output for AplikasiGuide
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AplikasiGuide wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AplikasiGuide_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[nama_file,nama_path] = uigetfile({'*.*'});

if ~isequal(nama_file,0)
    I = imread(fullfile(nama_path,nama_file));
    axes(handles.axes1)
    imshow(I)
    handles.I = I;
    guidata(hObject,handles)
else
    return
end

% --- Executes on button press in pushbutton1.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I = handles.I;
J = I(:,:,1);
K = im2bw(J,.6);
L = imcomplement(K);
str = strel('disk',5);
M = imclose(L,str);
N = imfill(M,'holes');
O = bwareaopen(N,5000);



R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

R(~O) = 0;
G(~O) = 0;
B(~O) = 0;

axes(handles.axes2)
imshow(R)
axes(handles.axes3)
imshow(G)
axes(handles.axes4)
imshow(B)
axes(handles.axes5)
imshow(O)

RGB = cat(3,R,G,B);
axes(handles.axes6)
imshow(RGB)









function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

total_images=1;

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
    set(handles.edit1,'String',kelas);
    set(handles.edit1,'String',akurasi);



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
