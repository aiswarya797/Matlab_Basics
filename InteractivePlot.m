%% Create an interactive plot
% Two sin waves, with all the part below the horizontal line in blue and
% all the part above the horizontal line in red. The horizontal line will
% be in green

%% Initial Plot (Stage 1 - stationary plot)

function InteractivePlot
hFig = figure;
hAx = axes;
x = linspace(-1,1,1000);
redY = sin(2*pi*x);
redY(redY>=0) = NaN;
blueY = sin(2*pi*x);
blueY(blueY<0) = NaN;
hold on 
handles.p = plot(x, redY,'r');
handles.q = plot(x, blueY,'b');
handles.y = yline(0, 'g');

handles.p.LineWidth = 5;
handles.q.LineWidth = 5;
handles.y.LineWidth = 5;

%% Interactive plot - Stage 2 - Modification to include moving green bar

hFig.WindowButtonDownFcn = @updateplot_click;
hFig.WindowButtonUpFcn = @updateplot_unclick;

    function updateplot_click(~,~)
    
    P = hAx.CurrentPoint;
    thresh = P(1,2);
    redY = sin(2*pi*x);
    blueY = sin(2*pi*x);
    redY(redY>thresh) = NaN;
    blueY(blueY<thresh) = NaN;

    handles.p.YData = redY;
    handles.q.YData = blueY;
    handles.y.Value = thresh;
    hFig.WindowButtonMotionFcn = @updateplot_move; 
    end

    function updateplot_move(~,~)
        P = hAx.CurrentPoint;
        thresh = P(1,2);
        redY = sin(2*pi*x);
        blueY = sin(2*pi*x);
        redY(redY>thresh) = NaN;
        blueY(blueY<thresh) = NaN;
        
        handles.p.YData = redY;
        handles.q.YData = blueY;
        handles.y.Value = thresh;
    end

    function updateplot_unclick(~,~)
        hFig.WindowButtonMotionFcn = '';
    end

end
