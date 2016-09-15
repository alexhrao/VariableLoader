function varargout = LoadVariables(varargin)
% LOADVARIABLES SoluCheck figure
%    Do not call LoadVariables by itself; it cannot function without
%    SoluCheck active. For more information, see ADVANCED OPTIONS.
%
% See also: AdvancedOptions, SoluCheck

% Last Modified by GUIDE v2.5 30-Sep-2015 00:15:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LoadVariables_OpeningFcn, ...
                   'gui_OutputFcn',  @LoadVariables_OutputFcn, ...
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


% --- Executes just before LoadVariables is made visible.
function LoadVariables_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<VANUS,*INUSL>
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LoadVariables (see VARARGIN)

% Choose default command line output for LoadVariables
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LoadVariables wait for user response (see UIRESUME)
% uiwait(handles.uiLLoadVariables);
cstFileName = {handles.stLFileName1};
cpbBrowse = {handles.pbLBrowse1};
cpbDelete = {handles.pbLDelete1};
hLoadVariables = handles.uiLLoadVariables;
setappdata(hLoadVariables, 'cstFileName', cstFileName);
setappdata(hLoadVariables, 'cpbBrowse', cpbBrowse);
setappdata(hLoadVariables, 'cpbDelete', cpbDelete);
handles.pbLConfirm.Enable = 'off';

% --- Outputs from this function are returned to the command line.
function varargout = LoadVariables_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pbLBrowse1.
function pbLBrowse1_Callback(hObject, eventdata, ~)
% hObject    handle to pbLBrowse1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(findobj('Tag', 'uiLLoadVariables'));
hLoadVariables = handles.uiLLoadVariables;
cstFileName = getappdata(hLoadVariables, 'cstFileName');
cpbBrowse = getappdata(hLoadVariables, 'cpbBrowse');
cpbDelete = getappdata(hLoadVariables, 'cpbDelete');
intLineNumber = hObject.Tag;
intLineNumber = str2double(intLineNumber(end));
[strFileName, strFilePath] = uigetfile('*.mat', 'Select your variable file:');
if strFileName == 0;
    return
end
handles.pbLConfirm.Enable = 'on';
set(findobj('Tag', ['stLFileName' num2str(intLineNumber)]), 'String', strFileName);
set(findobj('Tag', ['pbLDelete' num2str(intLineNumber)]), 'Visible', 'on');
cstFileName{intLineNumber + 1} = uicontrol(hLoadVariables, 'Style', 'text', 'String', '_____________________________________', 'FontSize', 10.0, 'Tag', ['stLFileName' num2str(intLineNumber + 1)], 'HorizontalAlignment', 'left');
setpixelposition(cstFileName{intLineNumber + 1}, getpixelposition(findobj('Tag', 'stLFileName1')) + [0 (-33 .* intLineNumber) 0 0])
cpbBrowse{intLineNumber + 1} = uicontrol(hLoadVariables, 'Style', 'pushbutton', 'String', 'Browse...', 'FontSize', 10.0, 'Tag', ['pbLBrowse' num2str(intLineNumber + 1)], 'Callback', @pbLBrowse1_Callback);
setpixelposition(cpbBrowse{intLineNumber + 1}, getpixelposition(findobj('Tag', 'pbLBrowse1')) + [0 (-33 .* intLineNumber) 0 0])
cpbDelete{intLineNumber + 1} = uicontrol(hLoadVariables, 'Style', 'pushbutton', 'Visible', 'off', 'String', 'Delete', 'FontSize', 10.0, 'Tag', ['pbLDelete' num2str(intLineNumber + 1)], 'Callback', @pbLDelete1_Callback);
setpixelposition(cpbDelete{intLineNumber + 1}, getpixelposition(findobj('Tag', 'pbLDelete1')) + [ 0 (-33 .* intLineNumber) 0 0]);

setpixelposition(findobj('Tag', 'pbLCancel'), getpixelposition(findobj('Tag', 'pbLCancel')) + [0 -33 0 0]);
setpixelposition(findobj('Tag', 'pbLConfirm'), getpixelposition(findobj('Tag', 'pbLConfirm')) + [0 -33 0 0]);
setappdata(hLoadVariables, ['cFilePath' num2str(intLineNumber)], {strFilePath, strFileName})
setappdata(hLoadVariables, 'intFileNumber', intLineNumber)
setappdata(hLoadVariables, 'cstFileName', cstFileName);
setappdata(hLoadVariables, 'cpbBrowse', cpbBrowse);
setappdata(hLoadVariables, 'cpbDelete', cpbDelete);

% --- Executes on button press in pbLDelete1.
function pbLDelete1_Callback(hObject, eventdata, handles)
% hObject    handle to pbLDelete1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
intNumber = hObject.Tag;
intNumber = str2double(intNumber(end));
hObject.Visible = 'off';
set(findobj('Tag', ['stLFileName' num2str(intNumber)]), 'Visible', 'off');
set(findobj('Tag', ['pbLBrowse' num2str(intNumber)]), 'Visible', 'off');
setappdata(findobj('Tag', 'uiLLoadVariables'), ['cFilePath' num2str(intNumber)], 0);
intTotal = getappdata(findobj('Tag', 'uiLLoadVariables'), 'intFileNumber');
for i = intNumber:intTotal + 1
    k = findobj('Tag', ['stLFileName' num2str(i)]);
    setpixelposition(k, getpixelposition(k) + [0 33 0 0]);
    k = findobj('Tag', ['pbLBrowse' num2str(i)]);
    setpixelposition(k, getpixelposition(k) + [0 33 0 0]);
    k = findobj('Tag', ['pbLDelete' num2str(i)]);
    setpixelposition(k, getpixelposition(k) + [0 33 0 0]);
end
logConfirm = false;
for k = 1:intTotal
    k = findobj('Tag', ['stLFileName' num2str(k)]); %#ok<FXSET>
    if k.Visible == true
        logConfirm = true;
        break;
    end
end
if ~logConfirm
    handles.pbLConfirm.Enable = 'off';
else
    handles.pbLConfirm.Enable = 'on';
end

% --- Executes on button press in pbLConfirm.
function pbLConfirm_Callback(hObject, eventdata, handles) %#ok<DEFNU>
% hObject    handle to pbLConfirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hLoadVariables = handles.uiLLoadVariables;
intFileNumber = getappdata(hLoadVariables, 'intFileNumber');
intFiles = 0;
vecPosns = zeros(1, intFileNumber);
for i = 1:intFileNumber
    cFileParts = getappdata(hLoadVariables, ['cFilePath' num2str(i)]);
    if iscell(cFileParts)
        intFiles = intFiles + 1;
        vecPosns(i) = i;
    end
end
vecPosns = vecPosns(vecPosns ~= 0);
cellFileNames = cell(1, intFiles);
for i = 1:intFiles
    cellFileNames{i} = getappdata(hLoadVariables, ['cFilePath' num2str(vecPosns(i))]);
end
for k = 1:intFiles
    if ~isnumeric(cellFileNames{k})
        stcVariables = load([cellFileNames{k}{:}]);
        for n = fieldnames(stcVariables)'
            assignin('base', n{1}, stcVariables.(n{1}));
        end
    end
end
close;

% --- Executes on button press in pbLCancel.
function pbLCancel_Callback(hObject, eventdata, handles) %#ok<*INUSD,DEFNU>
% hObject    handle to pbLCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;

function uiLLoadVariables_SizeChangedFcn(hObject, eventdata, handles) %#ok<DEFNU>
% hObject   handle to uiLLoadVariables
% eventdata reserved - to be defined in a future version of MATLAB
% handles   structure with handles and user data (see GUIDATA)
