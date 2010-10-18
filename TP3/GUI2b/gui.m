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

% Last Modified by GUIDE v2.5 18-Oct-2010 19:17:48

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

% default popup menu position
posX = 58.999999999999964;
posY = 25.357142857142847;

% set the popup menu position
pos = get(handles.popUpMenu, 'Position');
pos(1) = posX;
pos(2) = posY;
set(handles.popUpMenu, 'Position', pos);

% default panel position
posX = 58.714285714285694;
posY = 12.428571428571429;

% set the zero options panel position
pos = get(handles.zeroOptionsPanel, 'Position');
pos(1) = posX;
pos(2) = posY;
set(handles.zeroOptionsPanel, 'Position', pos);

% set the one option panel position
pos = get(handles.oneOptionPanel, 'Position');
pos(1) = posX;
pos(2) = posY;
set(handles.oneOptionPanel, 'Position', pos);

% set the two options panel position
pos = get(handles.twoOptionsPanel, 'Position');
pos(1) = posX;
pos(2) = posY;
set(handles.twoOptionsPanel, 'Position', pos);

% set the three options panel position
pos = get(handles.threeOptionsPanel, 'Position');
pos(1) = posX;
pos(2) = posY;
set(handles.threeOptionsPanel, 'Position', pos);

% set the three options panel position
pos = get(handles.sixOptionsPanel, 'Position');
pos(1) = posX;
pos(2) = posY;
set(handles.sixOptionsPanel, 'Position', pos);


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
drawnow;


dim = str2double(get(handles.medianFilterDim, 'string'));

%prcImg = medianFilter(srcImg);
prcImg = medianFilter2(srcImg,dim);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'median_filter.jpg');
drawnow;


% --- Executes on button press in lowpassfilter.
function lowpassfilter_Callback(hObject, eventdata, handles)
% hObject    handle to lowpassfilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');
drawnow;

dim = str2double(get(handles.lowPassFilterDim, 'string'));

%prcImg = lowFilter(srcImg, 3);
prcImg = lowFilter2(srcImg, dim);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'lowpass_filter.jpg');
drawnow;


% --- Executes on button press in highpassfilter.
function highpassfilter_Callback(hObject, eventdata, handles)
% hObject    handle to highpassfilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');
drawnow;

dim = str2double(get(handles.highPassFilterDim, 'string'));

%prcImg = highFilter(srcImg, 3);
prcImg = highFilter2(srcImg, dim);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'highpass_filter.jpg');
drawnow;


% --- Executes on button press in gaussianNoise.
function gaussianNoise_Callback(hObject, eventdata, handles)
% hObject    handle to gaussianNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');
drawnow;

mu = str2double(get(handles.gaussianNoiseMu, 'string'));
sigma = str2double(get(handles.gaussianNoiseSigma, 'string'));

prcImg = gaussianNoise(srcImg, mu, sigma);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'gaussian_noise.jpg');
drawnow;


% --- Executes on button press in rayleighNoise.
function rayleighNoise_Callback(hObject, eventdata, handles)
% hObject    handle to rayleighNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');
drawnow;

psi = str2double(get(handles.rayleighNoisePsi, 'string'));

prcImg = rayleighNoise(srcImg, psi);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'rayleigh_noise.jpg');
drawnow;


% --- Executes on button press in exponentialNoise.
function exponentialNoise_Callback(hObject, eventdata, handles)
% hObject    handle to exponentialNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');
drawnow;

lambda = str2double(get(handles.exponentialNoiseLambda, 'string'));

prcImg = exponentialNoise(srcImg, lambda);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'exponential_noise.jpg');
drawnow;


% --- Executes on button press in saltAndPepperNoise.
function saltAndPepperNoise_Callback(hObject, eventdata, handles)
% hObject    handle to saltAndPepperNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');
drawnow;

p1 = str2double(get(handles.saltAndPepperNoiseP1, 'string'));
p2 = str2double(get(handles.saltAndPepperNoiseP2, 'string'));

prcImg = saltAndPepperNoise(srcImg, p1, p2);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'saltandpepper_noise.jpg');
drawnow;

% --- Executes on button press in robertsOperator.
function robertsOperator_Callback(hObject, eventdata, handles)
% hObject    handle to robertsOperator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');
drawnow;

prcImg = robertsOperator(srcImg);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'roberts_operator.jpg');
drawnow;


% --- Executes on button press in prewittOperator.
function prewittOperator_Callback(hObject, eventdata, handles)
% hObject    handle to prewittOperator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');
drawnow;

prcImg = prewittOperator(srcImg);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'prewitt_operator.jpg');
drawnow;


% --- Executes on button press in sobelOperator.
function sobelOperator_Callback(hObject, eventdata, handles)
% hObject    handle to sobelOperator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');
drawnow;

prcImg = sobelOperator(srcImg);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'sobel_operator.jpg');
drawnow;


% --- Executes on button press in isotropicDiffusion.
function isotropicDiffusion_Callback(hObject, eventdata, handles)
% hObject    handle to isotropicDiffusion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');
drawnow;

dim = str2double(get(handles.isotropicDiffusionDim, 'string'));
sigma = str2double(get(handles.isotropicDiffusionSigma, 'string'));

prcImg = isotropicDiffusion(srcImg, sigma, dim);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'isotropic_diffusion.jpg');
drawnow;


% --- Executes on button press in anisotropicDiffusion.
function anisotropicDiffusion_Callback(hObject, eventdata, handles)
% hObject    handle to anisotropicDiffusion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;

set(handles.statusLabel, 'String', 'Processing...');
drawnow;

iterations = str2double(get(handles.anisotropicDiffusionIterations, 'string'));
sigma = str2double(get(handles.anisotropicDiffusionSigma, 'string'));
lambda = str2double(get(handles.anisotropicDiffusionLambda, 'string'));

prcImg = anisotropicDiffusion2(srcImg, lambda, sigma, iterations);
axes(handles.processedImageAxes);
imshow(prcImg.full,[]);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', 'anisotropic_diffusion.jpg');
drawnow;


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



function anisotropicDiffusionIterations_Callback(hObject, eventdata, handles)
% hObject    handle to anisotropicDiffusionIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of anisotropicDiffusionIterations as text
%        str2double(get(hObject,'String')) returns contents of anisotropicDiffusionIterations as a double


% --- Executes during object creation, after setting all properties.
function anisotropicDiffusionIterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to anisotropicDiffusionIterations (see GCBO)
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



function anisotropicDiffusionLambda_Callback(hObject, eventdata, handles)
% hObject    handle to anisotropicDiffusionLambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of anisotropicDiffusionLambda as text
%        str2double(get(hObject,'String')) returns contents of anisotropicDiffusionLambda as a double


% --- Executes during object creation, after setting all properties.
function anisotropicDiffusionLambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to anisotropicDiffusionLambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popUpMenu.
function popUpMenu_Callback(hObject, eventdata, handles)
% hObject    handle to popUpMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popUpMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from
%        popUpMenu


global selectedFnc;
global selectedFncName;

set(handles.zeroOptionsPanel, 'Visible', 'off');
set(handles.oneOptionPanel, 'Visible', 'off');
set(handles.twoOptionsPanel, 'Visible', 'off');
set(handles.threeOptionsPanel, 'Visible', 'off');
set(handles.sixOptionsPanel, 'Visible', 'off');

switch get(handles.popUpMenu,'Value')   
    case 1 % Gaussian Noise             
        % set the panel visible
        set(handles.twoOptionsPanel, 'Visible', 'on');
        
        % set the labels
        set(handles.twoOptionsLabel1, 'String', 'Mu:');
        set(handles.twoOptionsLabel2, 'String', 'Sigma:');
        
        % load the default values
        set(handles.twoOptionsValue1, 'String', '0');
        set(handles.twoOptionsValue2, 'String', '15');
        
        % set the selected function
        selectedFnc = @gaussianNoise;
        
        % set the file name
        selectedFncName = 'gaussian_noise.jpg';
        
    case 2 % Rayleigh Noise
        % set the panel visible
        set(handles.oneOptionPanel, 'Visible', 'on');
        
        % set the labels
        set(handles.oneOptionLabel, 'String', 'Psi:');
        
        % load the default value
        set(handles.oneOptionValue, 'String', '1');
        
        % set the selected function
        selectedFnc = @rayleighNoise;
        
        % set the file name
        selectedFncName = 'rayleigh_noise.jpg';
        
    case 3 % Exponential Noise
        % set the panel visible
        set(handles.oneOptionPanel, 'Visible', 'on');
        
        % set the label
        set(handles.oneOptionLabel, 'String', 'Lambda:');
        
        % load the default value
        set(handles.oneOptionValue, 'String', '10');
        
        % set the selected function
        selectedFnc = @exponentialNoise;
        
        % set the file name
        selectedFncName = 'exponential_noise.jpg';
        
    case 4 % Salt & Pepper Noise
        % set the panel visible
        set(handles.twoOptionsPanel, 'Visible', 'on');
        
        % set the labels
        set(handles.twoOptionsLabel1, 'String', 'p1:');
        set(handles.twoOptionsLabel2, 'String', 'p2:');
        
        % load the default value
        set(handles.twoOptionsValue1, 'String', '0.015');
        set(handles.twoOptionsValue2, 'String', '0.995');
        
        % set the selected function
        selectedFnc = @saltAndPepperNoise;
        
        % set the file name
        selectedFncName = 'gassian_noise.jpg';
        
    case 5 % Medan Filter
        % set the panel visible
        set(handles.oneOptionPanel, 'Visible', 'on');
        
        % set the label
        set(handles.oneOptionLabel, 'String', 'Dim:');
        
        % load the default value
        set(handles.oneOptionValue, 'String', '3');
        
        % set the selected function
        selectedFnc = @medianFilter2;
        
        % set the file name
        selectedFncName = 'median_filter.jpg';
        
    case 6 % Low Pass Filter
        % set the panel visible
        set(handles.oneOptionPanel, 'Visible', 'on');
        
        % set the label
        set(handles.oneOptionLabel, 'String', 'Dim:');
        
        % load the default value
        set(handles.oneOptionValue, 'String', '3');
        
        % set the selected function
        selectedFnc = @lowFilter2;
        
        % set the file name
        selectedFncName = 'low_pass_filter.jpg';
        
    case 7 % High Pass Filter
        % set the panel visible
        set(handles.oneOptionPanel, 'Visible', 'on');
        
        % set the label
        set(handles.oneOptionLabel, 'String', 'Dim:');
        
        % load the default value
        set(handles.oneOptionValue, 'String', '3');
        
        % set the selected function
        selectedFnc = @highFilter2;
        
        % set the file name
        selectedFncName = 'high_pass_filter.jpg';
        
    case 8 % Roberts Operator
        % set the panel visible
        set(handles.zeroOptionsPanel, 'Visible', 'on');
        
        % set the selected function
        selectedFnc = @robertsOperator;
        
        % set the file name
        selectedFncName = 'roberts_operator.jpg';
        
    case 9 % Prewitt Operator
        % set the panel visible
        set(handles.zeroOptionsPanel, 'Visible', 'on');
        
        % set the selected function
        selectedFnc = @prewittOperator;
        
        % set the file name
        selectedFncName = 'prewitt_operator';
        
    case 10 % Sobel Operator
        % set the panel visible
        set(handles.zeroOptionsPanel, 'Visible', 'on');
        
        % set the selected function
        selectedFnc = @sobelOperator;
        
        % set the file name
        selectedFncName = 'sobel_operator';
        
    case 11 % Isotropic Diffusion
        % set the panel visible
        set(handles.twoOptionsPanel, 'Visible', 'on');
        
        % set the labels
        set(handles.twoOptionsLabel1, 'String', 'Sigma:');
        set(handles.twoOptionsLabel2, 'String', 'Dim:');
        
        % load the default value
        set(handles.twoOptionsValue1, 'String', '10');
        set(handles.twoOptionsValue2, 'String', '10');
        
        % set the selected function
        selectedFnc = @isotropicDiffusion;
        
        % set the file name
        selectedFncName = 'isotropic_diffusion.jpg';
        
    case 12 % Anisotropic Diffusion
        % set the panel visible
        set(handles.threeOptionsPanel, 'Visible', 'on');
        
        % set the labels
        set(handles.threeOptionsLabel1, 'String', 'Lambda:');
        set(handles.threeOptionsLabel2, 'String', 'Sigma:');
        set(handles.threeOptionsLabel3, 'String', 'Iterations:');
        
        % load the default value
        set(handles.threeOptionsValue1, 'String', '0.25');
        set(handles.threeOptionsValue2, 'String', '10');
        set(handles.threeOptionsValue3, 'String', '20');
        
        % set the selected function
        selectedFnc = @anisotropicDiffusion2;
        
        % set the file name
        selectedFncName = 'anisotropic_diffusion.jpg';
        
    case 13 % Border Detector A
        % set the panel visible
        set(handles.zeroOptionsPanel, 'Visible', 'on');
        
        % set the selected function
        selectedFnc = @borderDetectorA;
        
        % set the file name
        selectedFncName = 'border_detector_A.jpg';
        
    case 14 % Kirsh Operator
        % set the panel visible
        set(handles.zeroOptionsPanel, 'Visible', 'on');
        
        % set the selected function
        selectedFnc = @kirshOperator;
        
        % set the file name
        selectedFncName = 'kirsh_operator.jpg';
    
    case 15 % Border Detector C
        % set the panel visible
        set(handles.zeroOptionsPanel, 'Visible', 'on');
        
        % set the selected function
        selectedFnc = @borderDetectorC;
        
        % set the file name
        selectedFncName = 'border_detector_C.jpg';
        
    case 16 % Border Detector D
        % set the panel visible
        set(handles.zeroOptionsPanel, 'Visible', 'on');
        
        % set the selected function
        selectedFnc = @borderDetectorD;
        
        % set the file name
        selectedFncName = 'border_detector_D.jpg';
        
    case 17 % Laplacian Filter
        % set the panel visible
        set(handles.zeroOptionsPanel, 'Visible', 'on');
        
        % set the selected function
        selectedFnc = @laplacianFilter;
        
        % set the file name
        selectedFncName = 'laplacian_filter.jpg';
        
    case 18 % LoG Filter
        % set the panel visible
        set(handles.twoOptionsPanel, 'Visible', 'on');
        
        % set the labels
        set(handles.twoOptionsLabel1, 'String', 'Sigma:');
        set(handles.twoOptionsLabel2, 'String', 'Dim:');
        
        % load the default value
        set(handles.twoOptionsValue1, 'String', '10');
        set(handles.twoOptionsValue2, 'String', '10');
        
        % set the selected function
        selectedFnc = @LOGFilter;
        
        % set the file name
        selectedFncName = 'log_filter.jpg';
    
    case 19 % Hough Transform
        % set the panel visible
        set(handles.sixOptionsPanel, 'Visible', 'on');
        
        % set the labels
        set(handles.sixOptionsLabel2, 'String', 'Threshold:');
        set(handles.sixOptionsLabel3, 'String', 'Rho/div:');
        set(handles.sixOptionsLabel4, 'String', 'Theta/div:');
        set(handles.sixOptionsLabel5, 'String', 'Epsilon:');
        set(handles.sixOptionsLabel6, 'String', 'Pertentage:');
        
        % load the default value
        set(handles.sixOptionsValue2, 'String', '128');
        set(handles.sixOptionsValue3, 'String', '500');
        set(handles.sixOptionsValue4, 'String', '200');
        set(handles.sixOptionsValue5, 'String', '1');
        set(handles.sixOptionsValue6, 'String', '0.5');
        
        % set the selected function
        selectedFnc = @houghTransform;
        
        % set the file name
        selectedFncName = 'hough_transform.jpg';
        
    otherwise
        % nothing...
end


% --- Executes during object creation, after setting all properties.
function popUpMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popUpMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function threeOptionsValue3_Callback(hObject, eventdata, handles)
% hObject    handle to threeOptionsLabel3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of threeOptionsLabel3 as text
%        str2double(get(hObject,'String')) returns contents of threeOptionsLabel3 as a double


% --- Executes during object creation, after setting all properties.
function threeOptionsLabel3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threeOptionsLabel3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function threeOptionsValue1_Callback(hObject, eventdata, handles)
% hObject    handle to threeOptionsValue1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of threeOptionsValue1 as text
%        str2double(get(hObject,'String')) returns contents of threeOptionsValue1 as a double


% --- Executes during object creation, after setting all properties.
function threeOptionsValue1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threeOptionsValue1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function threeOptionsValue2_Callback(hObject, eventdata, handles)
% hObject    handle to threeOptionsValue2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of threeOptionsValue2 as text
%        str2double(get(hObject,'String')) returns contents of threeOptionsValue2 as a double


% --- Executes during object creation, after setting all properties.
function threeOptionsValue2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threeOptionsValue2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit38_Callback(hObject, eventdata, handles)
% hObject    handle to threeOptionsValue1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of threeOptionsValue1 as text
%        str2double(get(hObject,'String')) returns contents of threeOptionsValue1 as a double


% --- Executes during object creation, after setting all properties.
function edit38_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threeOptionsValue1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit39_Callback(hObject, eventdata, handles)
% hObject    handle to threeOptionsValue2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of threeOptionsValue2 as text
%        str2double(get(hObject,'String')) returns contents of threeOptionsValue2 as a double


% --- Executes during object creation, after setting all properties.
function edit39_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threeOptionsValue2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function twoOptionsValue1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to twoOptionsValue1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function twoOptionsValue2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to twoOptionsValue2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function threeOptionsValue3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threeOptionsValue3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function oneOptionValue_Callback(hObject, eventdata, handles)
% hObject    handle to oneOptionValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of oneOptionValue as text
%        str2double(get(hObject,'String')) returns contents of oneOptionValue as a double


% --- Executes during object creation, after setting all properties.
function oneOptionValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to oneOptionValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in zeroOptionsButton.
function zeroOptionsButton_Callback(hObject, eventdata, handles)
% hObject    handle to zeroOptionsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;
global selectedFnc;
global selectedFncName;

set(handles.statusLabel, 'String', 'Processing...');
drawnow;

prcImg = selectedFnc(srcImg);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', selectedFncName);
drawnow;


% --- Executes on button press in oneOptionButton.
function oneOptionButton_Callback(hObject, eventdata, handles)
% hObject    handle to oneOptionButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;
global selectedFnc;
global selectedFncName;

set(handles.statusLabel, 'String', 'Processing...');
drawnow;

% load the value
val = str2double(get(handles.oneOptionValue, 'string'));

prcImg = selectedFnc(srcImg, val);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', selectedFncName);
drawnow;


% --- Executes on button press in twoOptionsButton.
function twoOptionsButton_Callback(hObject, eventdata, handles)
% hObject    handle to twoOptionsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;
global selectedFnc;
global selectedFncName;

set(handles.statusLabel, 'String', 'Processing...');
drawnow;

% load the value
val1 = str2double(get(handles.twoOptionsValue1, 'string'));
val2 = str2double(get(handles.twoOptionsValue2, 'string'));

prcImg = selectedFnc(srcImg, val1, val2);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', selectedFncName);
drawnow;


% --- Executes on button press in threeOptionsButton.
function threeOptionsButton_Callback(hObject, eventdata, handles)
% hObject    handle to threeOptionsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;
global selectedFnc;
global selectedFncName;

set(handles.statusLabel, 'String', 'Processing...');
drawnow;

% load the value
val1 = str2double(get(handles.threeOptionsValue1, 'string'));
val2 = str2double(get(handles.threeOptionsValue2, 'string'));
val3 = str2double(get(handles.threeOptionsValue3, 'string'));

prcImg = selectedFnc(srcImg, val1, val2, val3);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', selectedFncName);
drawnow;


% --- Executes on button press in sixOptionsButton.
function sixOptionsButton_Callback(hObject, eventdata, handles)
% hObject    handle to sixOptionsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global srcImg;
global prcImg;
global selectedFnc;
global selectedFncName;

set(handles.statusLabel, 'String', 'Processing...');
drawnow;

% load the value from the popup menu
switch get(handles.sixOptionsValue1,'Value')
    case 1 % Border Detector A
        val1 = @borderDetectorA;
    case 2 % Kirsh Operator
        val1 = @kirshOperator;
    case 3 % Border Detector C
        val1 = @borderDetectorC;
    case 4 % Border Detector D
        val1 = @borderDetectorD;
    case 5 % Roberts Operator
        val1 = @robertsOperator;
    case 6 % Prewitt Operator
        val1 = @prewittOperator;
    case 7 % Sobel Operator    
        val1 = @sobelOperator;
    otherwise
end

% load the other values
val2 = str2double(get(handles.sixOptionsValue2, 'string'));
val3 = str2double(get(handles.sixOptionsValue3, 'string'));
val4 = str2double(get(handles.sixOptionsValue4, 'string'));
val5 = str2double(get(handles.sixOptionsValue5, 'string'));
val6 = str2double(get(handles.sixOptionsValue6, 'string'));

prcImg = selectedFnc(srcImg, val1, val2, val3, val4, val5, val6);
axes(handles.processedImageAxes);
imshow(prcImg.full);

set(handles.statusLabel, 'String', 'Done!');
set(handles.processedImageName, 'String', selectedFncName);
drawnow;



function sixOptionsValue4_Callback(hObject, eventdata, handles)
% hObject    handle to sixOptionsValue4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sixOptionsValue4 as text
%        str2double(get(hObject,'String')) returns contents of sixOptionsValue4 as a double


% --- Executes during object creation, after setting all properties.
function sixOptionsValue4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sixOptionsValue4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sixOptionsValue2_Callback(hObject, eventdata, handles)
% hObject    handle to sixOptionsValue2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sixOptionsValue2 as text
%        str2double(get(hObject,'String')) returns contents of sixOptionsValue2 as a double


% --- Executes during object creation, after setting all properties.
function sixOptionsValue2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sixOptionsValue2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function sixOptionsValue3_Callback(hObject, eventdata, handles)
% hObject    handle to sixOptionsValue3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sixOptionsValue3 as text
%        str2double(get(hObject,'String')) returns contents of sixOptionsValue3 as a double


% --- Executes during object creation, after setting all properties.
function sixOptionsValue3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sixOptionsValue3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sixOptionsValue5_Callback(hObject, eventdata, handles)
% hObject    handle to sixOptionsValue5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sixOptionsValue5 as text
%        str2double(get(hObject,'String')) returns contents of sixOptionsValue5 as a double


% --- Executes during object creation, after setting all properties.
function sixOptionsValue5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sixOptionsValue5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sixOptionsValue6_Callback(hObject, eventdata, handles)
% hObject    handle to sixOptionsValue6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sixOptionsValue6 as text
%        str2double(get(hObject,'String')) returns contents of sixOptionsValue6 as a double


% --- Executes during object creation, after setting all properties.
function sixOptionsValue6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sixOptionsValue6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function sixOptionsValue1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sixOptionsValue1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sixOptionsValue1.
function sixOptionsValue1_Callback(hObject, eventdata, handles)
% hObject    handle to sixOptionsValue1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sixOptionsValue1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sixOptionsValue1
