function varargout = gui(varargin)
% GUI M-file for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 16-Sep-2010 16:11:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function sourceImageName_Callback(hObject, eventdata, handles)
% hObject    handle to sourceImageName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sourceImageName as text
%        str2double(get(hObject,'String')) returns contents of sourceImageName as a double


% --- Executes during object creation, after setting all properties.
function sourceImageName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sourceImageName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadImage.
function loadImage_Callback(hObject, eventdata, handles)
% hObject    handle to loadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;

name = get(handles.sourceImageName, 'string');

if (length(regexp(name, '([A-Za-z0-9]+)(.raw)', 'ignorecase')) == 1)
   heigth = get(handles.heightBox, 'string');
   width = get(handles.widthBox, 'string');
   srcImg = getRAW(name, str2num(heigth), str2num(width));
else
   srcImg = getRGB(name); 
end

axes(handles.sourceImageAxes);
imshow(srcImg.full);


% --- Executes on button press in medianFilter.
function medianFilter_Callback(hObject, eventdata, handles)
% hObject    handle to medianFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');

dim = str2double(get(handles.medianFilterDim, 'string'));

%prcImg = medianFilter(srcImg);
prcImg = medianFilter2(srcImg,dim);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'median_filter.jpg');


% --- Executes on button press in lowpassfilter.
function lowpassfilter_Callback(hObject, eventdata, handles)
% hObject    handle to lowpassfilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');

dim = str2double(get(handles.lowPassFilterDim, 'string'));

%prcImg = lowFilter(srcImg, 3);
prcImg = lowFilter2(srcImg, dim);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'lowpass_filter.jpg');


% --- Executes on button press in highpassfilter.
function highpassfilter_Callback(hObject, eventdata, handles)
% hObject    handle to highpassfilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');

dim = str2double(get(handles.highPassFilterDim, 'string'));

%prcImg = highFilter(srcImg, 3);
prcImg = highFilter2(srcImg, dim);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'highpass_filter.jpg');


% --- Executes on button press in gaussianNoise.
function gaussianNoise_Callback(hObject, eventdata, handles)
% hObject    handle to gaussianNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');

mu = str2double(get(handles.gaussianNoiseMu, 'string'));
sigma = str2double(get(handles.gaussianNoiseSigma, 'string'));

prcImg = gaussianNoise(srcImg, mu, sigma);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'gaussian_noise.jpg');


% --- Executes on button press in rayleighNoise.
function rayleighNoise_Callback(hObject, eventdata, handles)
% hObject    handle to rayleighNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');

psi = str2double(get(handles.rayleighNoisePsi, 'string'));

set(handles.statusLabel, 'String', 'Processing...');

prcImg = rayleighNoise(srcImg, psi);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'rayleigh_noise.jpg');


% --- Executes on button press in exponentialNoise.
function exponentialNoise_Callback(hObject, eventdata, handles)
% hObject    handle to exponentialNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');

lambda = str2double(get(handles.exponentialNoiseLambda, 'string'));

prcImg = exponentialNoise(srcImg, lambda);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'exponential_noise.jpg');


% --- Executes on button press in saltAndPepperNoise.
function saltAndPepperNoise_Callback(hObject, eventdata, handles)
% hObject    handle to saltAndPepperNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');

p1 = str2double(get(handles.saltAndPepperNoiseP1, 'string'));
p2 = str2double(get(handles.saltAndPepperNoiseP2, 'string'));

prcImg = saltAndPepperNoise(srcImg, p1, p2);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'saltandpepper_noise.jpg');

% --- Executes on button press in robertsOperator.
function robertsOperator_Callback(hObject, eventdata, handles)
% hObject    handle to robertsOperator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');

prcImg = robertsOperator(srcImg);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'roberts_operator.jpg');


% --- Executes on button press in prewittOperator.
function prewittOperator_Callback(hObject, eventdata, handles)
% hObject    handle to prewittOperator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');

prcImg = prewittOperator(srcImg);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'prewitt_operator.jpg');


% --- Executes on button press in sobelOperator.
function sobelOperator_Callback(hObject, eventdata, handles)
% hObject    handle to sobelOperator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');

prcImg = sobelOperator(srcImg);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'sobel_operator.jpg');


% --- Executes on button press in isotropicDiffusion.
function isotropicDiffusion_Callback(hObject, eventdata, handles)
% hObject    handle to isotropicDiffusion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');

dim = str2double(get(handles.isotropicDiffusionDim, 'string'));
sigma = str2double(get(handles.isotropicDiffusionSigma, 'string'));

prcImg = isotropicDiffusion(srcImg, sigma, dim);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'isotropic_diffusion.jpg');


% --- Executes on button press in anisotropicDiffusion.
function anisotropicDiffusion_Callback(hObject, eventdata, handles)
% hObject    handle to anisotropicDiffusion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');

dim = str2double(get(handles.isotropicDiffusionDim, 'string'));
sigma = str2double(get(handles.anisotropicDiffusionSigma, 'string'));
cn = str2double(get(handles.anisotropicDiffusionCN, 'string'));
cs = str2double(get(handles.anisotropicDiffusionCS, 'string'));
ce = str2double(get(handles.anisotropicDiffusionCE, 'string'));
cw = str2double(get(handles.anisotropicDiffusionCW, 'string'));

prcImg = anisotropicDiffusion(srcImg, sigma, dim, cn, cs, ce, cw);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'anisotropic_diffusion.jpg');


% --- Executes on button press in loadAsSourceImage.
function loadAsSourceImage_Callback(hObject, eventdata, handles)
% hObject    handle to loadAsSourceImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

srcImg = prcImg;
axes(handles.sourceImageAxes);
imshow(prcImg.full);


function processedImageName_Callback(hObject, eventdata, handles)
% hObject    handle to processedImageName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of processedImageName as text
%        str2double(get(hObject,'String')) returns contents of processedImageName as a double


% --- Executes during object creation, after setting all properties.
function processedImageName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to processedImageName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveImage.
function saveImage_Callback(hObject, eventdata, handles)
% hObject    handle to saveImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global prcImg;

name = get(handles.processedImageName, 'string');
saveImage(prcImg.full, name);



function widthBox_Callback(hObject, eventdata, handles)
% hObject    handle to widthBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of widthBox as text
%        str2double(get(hObject,'String')) returns contents of widthBox as a double


% --- Executes during object creation, after setting all properties.
function widthBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to widthBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function heightBox_Callback(hObject, eventdata, handles)
% hObject    handle to heightBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of heightBox as text
%        str2double(get(hObject,'String')) returns contents of heightBox as a double


% --- Executes during object creation, after setting all properties.
function heightBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to heightBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function saltAndPepperNoiseP1_Callback(hObject, eventdata, handles)
% hObject    handle to saltAndPepperNoiseP1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of saltAndPepperNoiseP1 as text
%        str2double(get(hObject,'String')) returns contents of saltAndPepperNoiseP1 as a double


% --- Executes during object creation, after setting all properties.
function saltAndPepperNoiseP1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to saltAndPepperNoiseP1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function saltAndPepperNoiseP2_Callback(hObject, eventdata, handles)
% hObject    handle to saltAndPepperNoiseP2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of saltAndPepperNoiseP2 as text
%        str2double(get(hObject,'String')) returns contents of saltAndPepperNoiseP2 as a double


% --- Executes during object creation, after setting all properties.
function saltAndPepperNoiseP2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to saltAndPepperNoiseP2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gaussianNoiseMu_Callback(hObject, eventdata, handles)
% hObject    handle to gaussianNoiseMu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gaussianNoiseMu as text
%        str2double(get(hObject,'String')) returns contents of gaussianNoiseMu as a double


% --- Executes during object creation, after setting all properties.
function gaussianNoiseMu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaussianNoiseMu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gaussianNoiseSigma_Callback(hObject, eventdata, handles)
% hObject    handle to gaussianNoiseSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gaussianNoiseSigma as text
%        str2double(get(hObject,'String')) returns contents of gaussianNoiseSigma as a double


% --- Executes during object creation, after setting all properties.
function gaussianNoiseSigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaussianNoiseSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rayleighNoisePsi_Callback(hObject, eventdata, handles)
% hObject    handle to rayleighNoisePsi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rayleighNoisePsi as text
%        str2double(get(hObject,'String')) returns contents of rayleighNoisePsi as a double


% --- Executes during object creation, after setting all properties.
function rayleighNoisePsi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rayleighNoisePsi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function exponentialNoiseLambda_Callback(hObject, eventdata, handles)
% hObject    handle to exponentialNoiseLambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of exponentialNoiseLambda as text
%        str2double(get(hObject,'String')) returns contents of exponentialNoiseLambda as a double


% --- Executes during object creation, after setting all properties.
function exponentialNoiseLambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to exponentialNoiseLambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function medianFilterDim_Callback(hObject, eventdata, handles)
% hObject    handle to medianFilterDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of medianFilterDim as text
%        str2double(get(hObject,'String')) returns contents of medianFilterDim as a double


% --- Executes during object creation, after setting all properties.
function medianFilterDim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to medianFilterDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowPassFilterDim_Callback(hObject, eventdata, handles)
% hObject    handle to lowPassFilterDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowPassFilterDim as text
%        str2double(get(hObject,'String')) returns contents of lowPassFilterDim as a double


% --- Executes during object creation, after setting all properties.
function lowPassFilterDim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowPassFilterDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function highPassFilterDim_Callback(hObject, eventdata, handles)
% hObject    handle to highPassFilterDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of highPassFilterDim as text
%        str2double(get(hObject,'String')) returns contents of highPassFilterDim as a double


% --- Executes during object creation, after setting all properties.
function highPassFilterDim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to highPassFilterDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function isotropicDiffusionDim_Callback(hObject, eventdata, handles)
% hObject    handle to isotropicDiffusionDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of isotropicDiffusionDim as text
%        str2double(get(hObject,'String')) returns contents of isotropicDiffusionDim as a double


% --- Executes during object creation, after setting all properties.
function isotropicDiffusionDim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to isotropicDiffusionDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function isotropicDiffusionSigma_Callback(hObject, eventdata, handles)
% hObject    handle to isotropicDiffusionSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of isotropicDiffusionSigma as text
%        str2double(get(hObject,'String')) returns contents of isotropicDiffusionSigma as a double


% --- Executes during object creation, after setting all properties.
function isotropicDiffusionSigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to isotropicDiffusionSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function anisotropicDiffusionCN_Callback(hObject, eventdata, handles)
% hObject    handle to anisotropicDiffusionCN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of anisotropicDiffusionCN as text
%        str2double(get(hObject,'String')) returns contents of anisotropicDiffusionCN as a double


% --- Executes during object creation, after setting all properties.
function anisotropicDiffusionCN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to anisotropicDiffusionCN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function anisotropicDiffusionCS_Callback(hObject, eventdata, handles)
% hObject    handle to anisotropicDiffusionCS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of anisotropicDiffusionCS as text
%        str2double(get(hObject,'String')) returns contents of anisotropicDiffusionCS as a double


% --- Executes during object creation, after setting all properties.
function anisotropicDiffusionCS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to anisotropicDiffusionCS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function anisotropicDiffusionDim_Callback(hObject, eventdata, handles)
% hObject    handle to anisotropicDiffusionDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of anisotropicDiffusionDim as text
%        str2double(get(hObject,'String')) returns contents of anisotropicDiffusionDim as a double


% --- Executes during object creation, after setting all properties.
function anisotropicDiffusionDim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to anisotropicDiffusionDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function anisotropicDiffusionSigma_Callback(hObject, eventdata, handles)
% hObject    handle to anisotropicDiffusionSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of anisotropicDiffusionSigma as text
%        str2double(get(hObject,'String')) returns contents of anisotropicDiffusionSigma as a double


% --- Executes during object creation, after setting all properties.
function anisotropicDiffusionSigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to anisotropicDiffusionSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function anisotropicDiffusionCE_Callback(hObject, eventdata, handles)
% hObject    handle to anisotropicDiffusionCE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of anisotropicDiffusionCE as text
%        str2double(get(hObject,'String')) returns contents of anisotropicDiffusionCE as a double


% --- Executes during object creation, after setting all properties.
function anisotropicDiffusionCE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to anisotropicDiffusionCE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function anisotropicDiffusionCW_Callback(hObject, eventdata, handles)
% hObject    handle to anisotropicDiffusionCW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of anisotropicDiffusionCW as text
%        str2double(get(hObject,'String')) returns contents of anisotropicDiffusionCW as a double


% --- Executes during object creation, after setting all properties.
function anisotropicDiffusionCW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to anisotropicDiffusionCW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit33_Callback(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit33 as text
%        str2double(get(hObject,'String')) returns contents of edit33 as a double


% --- Executes during object creation, after setting all properties.
function edit33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit34_Callback(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit34 as text
%        str2double(get(hObject,'String')) returns contents of edit34 as a double


% --- Executes during object creation, after setting all properties.
function edit34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
