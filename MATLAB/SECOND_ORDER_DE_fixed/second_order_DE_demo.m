
function varargout = second_order_DE_demo(varargin)
% SECOND_ORDER_DE_DEMO Application M-file for second_order_DE_demo.fig
%    FIG = SECOND_ORDER_DE_DEMO launch second_order_DE_demo GUI.
%    SECOND_ORDER_DE_DEMO('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.5 29-Oct-2012 21:54:01

if nargin == 0  % LAUNCH GUI

	fig = openfig(mfilename,'reuse');
    check = 1;
	% Generate a structure of handles to pass to callbacks, and store it. 
	handles = guihandles(fig);
    
    % initialize all function parameters
    handles.fig = fig;
    
    % Time interval of interest
    handles.t = -1:0.001:10;
    
    % Default value for the initial conditions
    handles.v0 = 0 ;
    handles.vdot0 = 0;
    
    % Defulat value for the coefficients b, c
	handles.b = 1 ;
    handles.c = 1 ;
    
    % Default value for the driving force
	handles.driving_force = 1; % This is the u(t) function
    
    % Set limits for various sliders
    handles.b_Min = 0.01 ;
	handles.b_Max = 10 ;
	handles.c_Min = 0.01 ;
	handles.c_Max = 10 ;
	handles.v0_Min = -10 ;
	handles.v0_Max = 10 ;
	handles.vdot0_Min = -10 ;
	handles.vdot0_Max = 10 ;
    
    set(handles.slider1, 'Max',handles.c_Max )
	set(handles.slider1, 'Min',handles.c_Min )
    set(handles.slider2, 'Max',handles.v0_Max )
	set(handles.slider2, 'Min',handles.v0_Min )
    set(handles.slider3, 'Max',handles.b_Max )
	set(handles.slider3, 'Min',handles.b_Min )
    set(handles.slider4, 'Max',handles.vdot0_Max )
	set(handles.slider4, 'Min',handles.vdot0_Min )
    
    % Set step sizes for sliders
	handles.slider1_step = [0.1 0.1];
	set(handles.slider1, 'SliderStep',handles.slider1_step )
    handles.slider2_step = [0.1 0.1];
	set(handles.slider2, 'SliderStep',handles.slider2_step )
    handles.slider3_step = [0.1 0.1];
	set(handles.slider3, 'SliderStep',handles.slider3_step )
    handles.slider4_step = [0.1 0.1];
	set(handles.slider4, 'SliderStep',handles.slider4_step )

    % Initialize all sliders to proper values
	set(handles.slider1, 'value',handles.c)
    set(handles.slider2, 'value',handles.v0)
    set(handles.slider3, 'value',handles.b)
    set(handles.slider4, 'value',handles.vdot0)
    
    % Initialize edit boxes to proper values
    set(handles.edit1, 'string',num2str(handles.c))
    set(handles.edit2, 'string',num2str(handles.v0))
    set(handles.edit3, 'string',num2str(handles.b))
    set(handles.edit4, 'string',num2str(handles.vdot0))
    
	% Initialize the hold graphs button to 'do not hold'
	set(handles.pushbutton4, 'value', 0);
    handles.holdgraphs = 0;

	% Set complementary and particular solution checkboxes to 'unchecked'
	% Set particular solution checkbox to 'checked'
    set(handles.checkbox1, 'value',0)
	set(handles.checkbox2, 'value',1)
	set(handles.checkbox3, 'value',0)
    
	handles.complementary = 0;
    handles.particular=1;
    handles.total=0;
    
    % Initial color for multiple graphs
	handles.nextcolor = 0 ;

	

	% Save all parameters
	guidata(fig, handles);
    
    % plot the initial graphs
    UpdatePlot(handles);
    
	if nargout > 0
		varargout{1} = fig;
	end

elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

	try
		if (nargout)
			[varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
		else
			feval(varargin{:}); % FEVAL switchyard
        end
       
	catch
		disp(lasterr);
    end
    
end


%| ABOUT CALLBACKS:
%| GUIDE automatically appends subfunction prototypes to this file, and 
%| sets objects' callback properties to call them through the FEVAL 
%| switchyard above. This comment describes that mechanism.
%|
%| Each callback subfunction declaration has the following form:
%| <SUBFUNCTION_NAME>(H, EVENTDATA, HANDLES, VARARGIN)
%|
%| The subfunction name is composed using the object's Tag and the 
%| callback type separated by '_', e.g. 'slider2_Callback',
%| 'figure1_CloseRequestFcn', 'axis1_ButtondownFcn'.
%|
%| H is the callback object's handle (obtained using GCBO).
%|
%| EVENTDATA is empty, but reserved for future use.
%|
%| HANDLES is a structure containing handles of components in GUI using
%| tags as fieldnames, e.g. handles.figure1, handles.slider2. This
%| structure is created at GUI startup using GUIHANDLES and stored in
%| the figure's application data using GUIDATA. A copy of the structure
%| is passed to each callback.  You can store additional information in
%| this structure at GUI startup, and you can change the structure
%| during callbacks.  Call guidata(h, handles) after changing your
%| copy to replace the stored original so that subsequent callbacks see
%| the updates. Type "help guihandles" and "help guidata" for more
%| information.
%|
%| VARARGIN contains any extra arguments you have passed to the
%| callback. Specify the extra arguments by editing the callback
%| property in the inspector. By default, GUIDE sets the property to:
%| <MFILENAME>('<SUBFUNCTION_NAME>', gcbo, [], guidata(gcbo))
%| Add any extra arguments after the last argument, before the final
%| closing parenthesis.


% --------------------------------------------------------------------
function varargout = slider1_Callback(h, eventdata, handles, varargin)

% Slider for parameter c

c_num = get(handles.slider1,'Value');
set(handles.edit1,'String',num2str(c_num));
handles.c = c_num ;

guidata(handles.fig, handles);
UpdatePlot(handles);




% --------------------------------------------------------------------
function varargout = edit1_Callback(h, eventdata, handles, varargin)
% Edit box for parameter c
c_str = get(handles.edit1,'String');
c_num = str2num(c_str) ;

if( c_num < handles.c_Min )
	c_num = handles.c_Min ;
elseif( c_num > handles.c_Max )
	c_num = handles.c_Max ;
end

handles.c = c_num ;
set(handles.edit1,'String',num2str(c_num));
set(handles.slider1,'Value',c_num);

guidata(handles.fig, handles);
UpdatePlot(handles);






% --------------------------------------------------------------------
function varargout = popupmenu1_Callback(h, eventdata, handles, varargin)

% Popup menu for selecting the driving force

handles.driving_force = get(gcbo,'value');
guidata(handles.fig, handles);
UpdatePlot(handles);



% --------------------------------------------------------------------
function varargout = slider2_Callback(h, eventdata, handles, varargin)

% Slider for initial condition v(0)

initial_num = get(handles.slider2,'Value');
set(handles.edit2,'String',num2str(initial_num));
handles.v0 = initial_num;

guidata(handles.fig, handles);
UpdatePlot(handles);



% --------------------------------------------------------------------
function varargout = edit2_Callback(h, eventdata, handles, varargin)

% Edit box for initial condition v(0)

initial_string = get(handles.edit2,'String');
initial_num = str2num(initial_string) ;
handles.v0 = initial_num;

if( initial_num < handles.v0_Min )
	initial_num = handles.v0_Min ;
elseif( initial_num > handles.v0_Max )
	initial_num = handles.v0_Max ;
end

handles.v0 = initial_num ;
set(handles.edit2,'String',num2str(initial_num));
set(handles.slider2,'Value',initial_num);

guidata(handles.fig, handles);
UpdatePlot(handles);


% --------------------------------------------------------------------
function varargout = slider3_Callback(h, eventdata, handles, varargin)
% Slider for parameter b

b_num = get(handles.slider3,'Value');
set(handles.edit3,'String',num2str(b_num));
handles.b = b_num ;

guidata(handles.fig, handles);
UpdatePlot(handles);





% --------------------------------------------------------------------
function varargout = edit3_Callback(h, eventdata, handles, varargin)

% Edit box for parameter b
b_str = get(handles.edit3,'String');
b_num = str2num(b_str) ;

if( b_num < handles.b_Min )
	b_num = handles.b_Min ;
elseif( b_num > handles.b_Max )
	b_num = handles.b_Max ;
end

handles.b = b_num ;
set(handles.edit3,'String',num2str(b_num));
set(handles.slider3,'Value',b_num);

guidata(handles.fig, handles);
UpdatePlot(handles);




% --------------------------------------------------------------------
function varargout = slider4_Callback(h, eventdata, handles, varargin)

% Slider for initial condition vdot(0)

initial_num = get(handles.slider4,'Value');
set(handles.edit4,'String',num2str(initial_num));
handles.vdot0 = initial_num;

guidata(handles.fig, handles);
UpdatePlot(handles);



% --------------------------------------------------------------------
function varargout = edit4_Callback(h, eventdata, handles, varargin)

% Edit box for initial condition vdot(0)

initial_string = get(handles.edit4,'String');
initial_num = str2num(initial_string) ;
handles.vdot0 = initial_num;

if( initial_num < handles.vdot0_Min )
	initial_num = handles.vdot0_Min ;
elseif( initial_num > handles.vdot0_Max )
	initial_num = handles.vdot0_Max ;
end

handles.vdot0 = initial_num ;
set(handles.edit4,'String',num2str(initial_num));
set(handles.slider4,'Value',initial_num);

guidata(handles.fig, handles);
UpdatePlot(handles);





% --------------------------------------------------------------------
function varargout = checkbox1_Callback(h, eventdata, handles, varargin)
% Complementary solution
handles.complementary = get(handles.checkbox1, 'value');

guidata(handles.fig, handles);

UpdatePlot(handles);



% --------------------------------------------------------------------
function varargout = checkbox2_Callback(h, eventdata, handles, varargin)
% particular solution
handles.particular = get(handles.checkbox2, 'value');

guidata(handles.fig, handles);
UpdatePlot(handles);



% --------------------------------------------------------------------
function varargout = checkbox3_Callback(h, eventdata, handles, varargin)

% Total solution
handles.total = get(handles.checkbox3, 'value');

guidata(handles.fig, handles);
UpdatePlot(handles);




% --------------------------------------------------------------------
function varargout = pushbutton1_Callback(h, eventdata, handles, varargin)

% Push button for hold graphs
handles.holdgraphs = get(handles.pushbutton1, 'value');

guidata(handles.fig, handles);
UpdatePlot(handles);




% --------------------------------------------------------------------
function varargout = pushbutton2_Callback(h, eventdata, handles, varargin)


% Push button for reset
axes(handles.axes2);
cla
axes(handles.axes1);
cla


    
    % Initialize the handles data structure
    % Default value for the initial conditions
    handles.v0 = 0 ;
    handles.vdot0 = 0;
    
    % Defulat value for the coefficients b, c
	handles.b = 1 ;
    handles.c = 1 ;
    
    % Default value for the driving force
	handles.driving_force = 1; % This is the u(t) function
    
    % Default value popupmenu1,'value',1)
    set(handles.popupmenu1,'Value',1)
     
    
    % Initialize the hold graphs button to 'do not hold'
	set(handles.pushbutton4, 'value', 0);
    handles.holdgraphs = 0;
    
    % Initial color for multiple graphs
	handles.nextcolor = 0 ;
    
	% Reset solutions checkboxes 
	set(handles.checkbox1, 'value',0)
	set(handles.checkbox2, 'value',1)
	set(handles.checkbox3, 'value',0)
	handles.complementary = 0;
    handles.particular=1;
    handles.total=0;
    
	% Initialize all sliders to proper values
	set(handles.slider1, 'value',handles.c)
    set(handles.slider2, 'value',handles.v0)
    set(handles.slider3, 'value',handles.b)
    set(handles.slider4, 'value',handles.vdot0)
    
    % Initialize edit boxes to proper values
    set(handles.edit1, 'string',num2str(handles.c))
    set(handles.edit2, 'string',num2str(handles.v0))
    set(handles.edit3, 'string',num2str(handles.b))
    set(handles.edit4, 'string',num2str(handles.vdot0))
    
	% Initial color for multiple graphs
	handles.nextcolor = 0 ;
    
guidata(handles.fig, handles);
UpdatePlot(handles);




% --------------------------------------------------------------------
function varargout = pushbutton3_Callback(h, eventdata, handles, varargin)


% Push button for printing
print -deps figure.eps



% --------------------------------------------------------------------
function varargout = pushbutton4_Callback(h, eventdata, handles, varargin)


% Push button for close and exit

close(handles.fig)



% --------------------------------------------------------------------
 function UpdatePlot(handles)

     
 % Get parameter values from the handles data structure 
 b = handles.b;
 c = handles.c;
 v0 = handles.v0;
 vdot0 = handles.vdot0;
 t = handles.t;
 
 
 % Initialize driving force parameters
 w0 = 1;
 A = 1;
 d = -1;
  
 % Plot the driving force
 
 % Find out the chosen driving force
 
 switch handles.driving_force
    case 1   %  u(t)
        vs =   (t >= 0);
    case 2  % exp(-t)
        vs = exp(-t) .* (t >= 0) ;
    case 3 % sin(t)
        vs = cos(t) .* (t >= 0) ;
    otherwise
        vs = zeros(size(t));
 end
 
 axes(handles.axes1)
 h = plot(t,vs);
 set(h,'LineWidth',2)
 grid on
 xlabel('t -->')
 ylabel('v_s(t)')
 axis([min(t) max(t) min(vs)-0.1 max(vs)+0.1])




 % Now plot the solution
 
 % Determine what solution is requested
 
 complementary = handles.complementary;
 particular = handles.particular;
 total = handles.total;
  
 switch handles.driving_force
    case 1 %'u(t)',
        vp = (A/c ) * (t >=0);
        % Value of vp(t) at t=0
        vp0 = A/c;
        vpdot0 = 0;
    case  2 %  'exp(-t)',
        vp = A/ (d^2+b*d+c) * (exp(d*t) .* (t >= 0) );
        vp0 =A/ (d^2+b*d+c);
        vpdot0 = A*d / (d^2+b*d+c);
    case 3 %'cos(t)',
        C = b*w0*A /   ((c-w0^2)^2+b^2*w0^2);
        D = (c-w0^2)*A/((c-w0^2)^2+b^2*w0^2);
        vp  = ( C * sin(w0*t)+ D*cos(w0*t) ) .* (t >= 0) ;
        vp0 = D ;
        vpdot0 =  C*w0 ;
    otherwise
        vp = zeros(size(t));
        vp0 = 0;
        vpdot0=0;
 end

  zeta = b/(2*sqrt(c));
  lambda1 = (-b + sqrt(b^2-4*c))/2;
  lambda2 = (-b - sqrt(b^2-4*c))/2;
  if( zeta < 1 )    % complex roots
      alpha = real(lambda1);
      beta = imag(lambda1);
      % Find the constants for the complementary solution
      AA = [ 1 0; alpha -beta];
      bb = 0.5* [ v0 - vp0; vdot0 - vpdot0];
      xx = inv(AA) * bb;
      phi = atan2(xx(2),xx(1));
      if( abs(bb(1)) > 0.0000001) 
            CC = bb(1)/cos(phi);
      else
            CC = bb(2)/(-beta);
      end
      vc = 2*CC*exp(alpha * t) .* cos(beta*t+phi) .* (t >=0);
  elseif( zeta > 1 )  % real roots
      % Find the constants for the complementary solution
      AA = [ 1 1 ; lambda1 lambda2];
      bb= [ v0 - vp0; vdot0 - vpdot0];
      xx = inv(AA) * bb;
      vc = (xx(1)*exp( lambda1 * t) + xx(2)*exp( lambda2 * t)).* (t >=0);
  else      % critically dumped case
      vc = zeros(size(t));
  end
      
 % Find the total solution 
 vt = vc+vp;
 
 axes(handles.axes2)
 % take care of the hold graphs button
if( handles.holdgraphs == 1 ) 
	hold on	% hold the graphs
    % Change color in every run
    handles.nextcolor = mod(handles.nextcolor + 1 , 5) ;
    color = nextcolor(handles.nextcolor);
else
	cla		% clear the previous graphs
end

 if( complementary == 1 )
    h = plot(t,vc);
    set(h,'LineWidth',2)
    
    if( handles.holdgraphs == 0 )
        set(h,'Color','red' )
    else
        set(h,'Color',color )
    end
    hold on
    h = plot(t,vs,'-.');
    set(h,'LineWidth',2)
    grid on
end

 if( particular == 1 )
    if( ( complementary == 1 ) | ( total == 1 ) ) 
        hold on
    end 
    h = plot(t,vp);
    set(h,'LineWidth',2)
    if( handles.holdgraphs == 0 )
        set(h,'Color','blue' )
    else
        set(h,'Color',color )
    end
    hold on
    h = plot(t,vs,'-.');
    set(h,'LineWidth',2)
    grid on
end

 if( total == 1 )
    if( ( complementary == 1 ) | ( particular == 1 ) ) 
        hold on
    end 
    h = plot(t,vt);
    set(h,'LineWidth',3)
    if( handles.holdgraphs == 0 )
        set(h,'Color','green' )
    else
        set(h,'Color',color )
    end
    hold on
    h = plot(t,vs,'-.');
    set(h,'LineWidth',2)
    grid on
end

axis auto
ax = axis;
axis([min(t) max(t) ax(3)-0.1 ax(4)+0.1])
 

xlabel('t -->')
%ylabel('v_s(t)')
hold off
 
 set(gcf, 'name', 'Second Order DE demo');
 
 guidata(handles.fig, handles);


% --------------------------------------------------------------------
function yy = nextcolor(nextcolor)

switch nextcolor 
	case 0, yy = 'red' ;
	case 1, yy = 'green' ;
	case 2, yy = 'blue' ;
	case 3, yy = 'magenta' ;
	case 4, yy = 'cyan' ;
	otherwise, yy = 'green' ;
end
