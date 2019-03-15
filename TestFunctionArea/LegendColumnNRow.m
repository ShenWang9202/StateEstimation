% Example data
xData = linspace(0,pi);
y1 = sin(xData);
y2 = cos(xData);
y3 = sin(xData.^2);
y4 = cos(xData.^2);
% Plot the first two sets of data
ph1(1) = plot(xData,y3,'-ko','DisplayName','Y3 Legend Text');
hold on
ph1(2) = plot(xData,y4,'-bs','DisplayName','Y4 Legend Text');
% Create the first legend
lh1 = legend(ph1,'Location','NorthOutside','Orientation','horizontal');
lh1_position = get(lh1,'Position');
% Now set any axis properties that you want (Font, Ticks, etc)
fontSize = 16;
xlimits = [0,pi];
ylimits = [-1, 1];
xticks  = [0, pi/2, pi];
yticks  = [-1, 0, 1];
xTickLabels = {'0', 'pi/2', 'pi'};
set(gca,'XLim',xlimits,'YLim',ylimits,'FontSize',fontSize,'XTick',xticks,'YTick',yticks,'xTickLabel',xTickLabels);
% Name the first axis ax1 and create a second axis on top of the first
ax1 = gca;
ax2 = axes('Position',get(ax1,'Position'));
% Plot the second two sets of data on ax2
ph2(1) = plot(xData,y1,'-rd','DisplayName','Y1 Legend Text','Parent',ax2);
hold on
ph2(2) = plot(xData,y2,'-g^','DisplayName','Y2 Legend Text','Parent',ax2);
% Again set any axis properties that you want (Font, Ticks, etc) to make sure that the Legend fonts are the same
set(ax2,'XLim',xlimits,'YLim',ylimits,'FontSize',fontSize,'XTick',xticks,'YTick',yticks);
% Now, link the first axis to the second and make the second invisible
linkaxes([ax1 ax2],'xy');
set(ax2,'Color','none','XTick',[],'YTick',[],'Box','off');
% Now make the second legend just above the first
lh2 = legend(ax2,ph2,'Orientation','horizontal');
lh2_position = lh1_position;
lh2_position(2) = lh1_position(2)+1.25*lh2_position(4);
set(lh2,'Position',lh2_position);