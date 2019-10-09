function varargout = svr_gui(varargin)
% SVR_GUI MATLAB code for svr_gui.fig
%      VSR_GUI, by itself, creates a new SVR_GUI or raises the existing
%      singleton*.
%
%      H = SVR_GUI returns the handle to a new SVR_GUI or the handle to
%      the existing singleton*.
%
%      SVR_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SVR_GUI.M with the given input arguments.
%
%      SVR_GUI('Property','Value',...) creates a new SVR_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before svr_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to svr_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vsr_gui

% Last Modified by GUIDE v2.5 09-Oct-2019 20:38:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @svr_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @svr_gui_OutputFcn, ...
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


% --- Executes just before vsr_gui is made visible.
function svr_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vsr_gui (see VARARGIN)

% Choose default command line output for vsr_gui
handles.output = hObject;
handles.sampleFile = '';
handles.ccdSize = 0;
handles.objMagFactor = 0;
handles.lightsheetThinkness = 0;
handles.scanStep = 0;
handles.offAxisAngle = 0;

handles.lateralEnhanFactor = 4;
handles.axialEnhanFactor = 3;
handles.algorithm = 0;
handles.outputFile = '';

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vsr_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = svr_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function et_lateral_factor_Callback(hObject, eventdata, handles)
% hObject    handle to et_lateral_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_lateral_factor as text
%        str2double(get(hObject,'String')) returns contents of et_lateral_factor as a double


% --- Executes during object creation, after setting all properties.
function et_lateral_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_lateral_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_axial_factor_Callback(hObject, eventdata, handles)
% hObject    handle to et_axial_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_axial_factor as text
%        str2double(get(hObject,'String')) returns contents of et_axial_factor as a double


% --- Executes during object creation, after setting all properties.
function et_axial_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_axial_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ppm_algo.
function ppm_algo_Callback(hObject, eventdata, handles)
% hObject    handle to ppm_algo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ppm_algo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ppm_algo


% --- Executes during object creation, after setting all properties.
function ppm_algo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ppm_algo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






function et_ccdsize_Callback(hObject, eventdata, handles)
% hObject    handle to et_ccdsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_ccdsize as text
%        str2double(get(hObject,'String')) returns contents of et_ccdsize as a double


% --- Executes during object creation, after setting all properties.
function et_ccdsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_ccdsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_obj_mag_factor_Callback(hObject, eventdata, handles)
% hObject    handle to et_obj_mag_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_obj_mag_factor as text
%        str2double(get(hObject,'String')) returns contents of et_obj_mag_factor as a double


% --- Executes during object creation, after setting all properties.
function et_obj_mag_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_obj_mag_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_fwhm_of_lightsheet_Callback(hObject, eventdata, handles)
% hObject    handle to et_fwhm_of_lightsheet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_fwhm_of_lightsheet as text
%        str2double(get(hObject,'String')) returns contents of et_fwhm_of_lightsheet as a double


% --- Executes during object creation, after setting all properties.
function et_fwhm_of_lightsheet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_fwhm_of_lightsheet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_scanstep_Callback(hObject, eventdata, handles)
% hObject    handle to et_scanstep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_scanstep as text
%        str2double(get(hObject,'String')) returns contents of et_scanstep as a double


% --- Executes during object creation, after setting all properties.
function et_scanstep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_scanstep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function preview_sample_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_scanstep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.




function et_off_axis_angle_Callback(hObject, eventdata, handles)
% hObject    handle to et_off_axis_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_off_axis_angle as text
%        str2double(get(hObject,'String')) returns contents of et_off_axis_angle as a double


% --- Executes during object creation, after setting all properties.
function et_off_axis_angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_off_axis_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in btn_open.
function btn_open_Callback(hObject, eventdata, handles)
% hObject    handle to btn_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[sampleFile ,pathName] = uigetfile('*.tif','choose sample image stack');
handles.sampleFile = fullfile(pathName,sampleFile);
preview = imread(handles.sampleFile,1);

guidata(hObject,handles);

axes(handles.preview_sample);
imshow(preview, []);
set(handles.slider_previewControl,'Enable', 'on');

% --- Executes on slider movement.
function slider_previewControl_Callback(hObject, eventdata, handles)
% hObject    handle to slider_previewControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

minV = get(hObject,'Min');
maxV = get(hObject,'Max');
value = get(hObject,'Value');
info = imfinfo(handles.sampleFile);
depth = numel(info);
currentDepth = floor(value/(maxV - minV) * (depth - 1)) + 1;
preview = imread(handles.sampleFile,currentDepth);
axes(handles.preview_sample);
imshow(preview, []);

% --- Executes during object creation, after setting all properties.
function slider_previewControl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_previewControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on button press in btn_break.
function btn_break_Callback(hObject, eventdata, handles)
% hObject    handle to btn_break (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_start.
function btn_start_Callback(hObject, eventdata, handles)
% hObject    handle to btn_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ccdSize = get(handles.et_ccdsize,'String');
objMagFactor = get(handles.et_obj_mag_factor,'String');
scanStep = get(handles.et_scanstep,'String');
lightsheetThickness = get(handles.et_fwhm_of_lightsheet,'String');
offAxisAngle = get(handles.et_off_axis_angle,'String');
lateralEnhanFactor = get(handles.et_lateral_factor,'string');
axialEnhanFactor = get(handles.et_axial_factor,'String');


ccdSize = str2double(ccdSize);
objMagFactor = str2double(objMagFactor);
scanStep = str2double(scanStep);
lightsheetThickness = str2double(lightsheetThickness);
offAxisAngle = str2double(offAxisAngle);

lateralEnhanFactor = str2double(lateralEnhanFactor);
axialEnhanFactor = str2double(axialEnhanFactor);

xy_step = scanStep * sin(deg2rad(offAxisAngle)); 
z_step = sqrt((scanStep * cos(deg2rad(offAxisAngle)))^2 - (xy_step)^2);

lr_voxel_lateral = ccdSize / objMagFactor;
lr_voxel_axial = lightsheetThickness / 2;
lr_num = floor(lr_voxel_lateral / xy_step);
layer_interval = floor(lightsheetThickness * 0.5 /  z_step);

%% calculate shift 
xy_shift_pixel = xy_step / lr_voxel_lateral;
z_shift_pixel = z_step / lr_voxel_axial;
fprintf('[*] lateral shift (in pixel) : %.3f  axial shift (in pixel) : %.3f\n', xy_shift_pixel, z_shift_pixel);
shift_xy = 0: xy_shift_pixel : (lr_num-1)*xy_shift_pixel;
shift_z = zeros(1,lr_num);
for i = 1 : lr_num
    shift_z(i) = (i-1) * z_shift_pixel;
end

sample = imread3D2(handles.sampleFile);
lr_set = generateLrSet(sample,lr_num,layer_interval);

%psf = psf_generator(lateralEnhanFactor, axialEnhanFactor, offAxisAngle, lr_voxel_lateral, lr_voxel_axial);
%psf = psf_generator(1, 1, offAxisAngle, lr_voxel_lateral, lr_voxel_axial);
[~, psf] = psf3d_gene(ccdSize/objMagFactor,lightsheetThickness,[lateralEnhanFactor, axialEnhanFactor]);
write3d(psf, '/psf.tif');
algo = get(handles.ppm_algo,'value');

%
%shift and add + deconvlution
if algo == 1
    robustSR3D(lr_set, shift_xy, shift_z, psf, lateralEnhanFactor, axialEnhanFactor, true);
elseif algo == 2
    fastRobustSR(lr_set, psf, lr_voxel_lateral, lightsheetThickness, scanStep, offAxisAngle, [lateralEnhanFactor, axialEnhanFactor], false);
end
