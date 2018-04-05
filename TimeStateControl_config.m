close all;
clear;

% TODO : overview description

% ZigZag curve
InitialState = [ 4;8;pi/2 ]; % x, y, yaw
% 曲線を構成する点の座標
x_vector = [  1,  3,  6,  7,  9, 11,  13 ];
y_vector = [  4,  7,  6,  3,  1,  3,  7 ];

% Straight
% InitialState = [ 0;0;3*pi/4 ]; % x, y, yaw
% 曲線を構成する点の座標
% x_vector = [ -3.0, -1.0,  6.0,  7.0 ];
% y_vector = [ -0.1,  0.3,  1.7,  1.9 ];

% Wheel base (m)
l = 0.256;

% Limit of steer angle (rad)
delta_min = - pi / 9;
delta_max = + pi / 9;

% Catmull-Rom splineを構成する点の数（固定）
NumOfCriteria = 4;

% 区間数（Catmull-Rom splineでは4点の座標を定義すると1区間できる．5点で2区間）
NumOfSection = length( x_vector ) - ( NumOfCriteria - 1 );

% Define Spline coefficient
CatmullRomSpline_Const = [ ...
    ( -1/2 ), ( +1/1 ), ( -1/2 ), ( +0/1 );
    ( +3/2 ), ( -5/2 ), ( +0/1 ), ( +1/1 );
    ( -3/2 ), ( +2/1 ), ( +1/2 ), ( +0/1 );
    ( +1/2 ), ( -1/2 ), ( +0/1 ), ( +0/1 );
];

CurveConstant = CatmullRomSpline_Const;

SamplingPeriod = 0.1; % Sampling period of time state controller (s)
SimPeriod = 0.1; % スコープのサンプリング周期 (s)
SimTime = 30; % シミュレーション時間 (s)

% シミュレーション実行
sim( 'TimeStateControl_model', SimTime );

% 描画系
AllTime = tic();
for time_cnt = 1:length( PlantOutput )
    currentTime = tic();
    clf;
    figure(1); hold on;
    
    % Draw trajectory
    plot( PlantOutput(1:time_cnt,2), PlantOutput(1:time_cnt,3), 'Color', [0.0,0.0,1.0] );
    axis equal;

    % Draw azimuth
    buff_x = [ 
        0;
        l * cos( PlantOutput(time_cnt,4) );
        l * cos( PlantOutput(time_cnt,4) ) + l * cos( PlantOutput(time_cnt,4)+SteerOutput(time_cnt,2) );
    ] + PlantOutput(time_cnt,2);
    
    buff_y = [ 
        0;
        l * sin( PlantOutput(time_cnt,4) );
        l * sin( PlantOutput(time_cnt,4) ) + l * sin( PlantOutput(time_cnt,4)+SteerOutput(time_cnt,2) );
    ] + PlantOutput(time_cnt,3);
    
    scatter( buff_x, buff_y, 'MarkerEdgeColor', 'None', 'MarkerFaceColor', [1.0,0.0,0.0] );
    plot( buff_x, buff_y, 'Color', [1.0,0.0,0.0] );
    
    % Draw minimum distance circle
    th_range = linspace( 0, ( 2 * pi ), 30 );
    
    buff_x = DistanceOutput(time_cnt,2) * cos( th_range ) + PlantOutput(time_cnt,2);
    buff_y = DistanceOutput(time_cnt,2) * sin( th_range ) + PlantOutput(time_cnt,3);
    
    plot( buff_x, buff_y, 'Color', [1.0,0.0,0.0] );
    
    % Draw tangent
    buff_x = [
        0;
        2*DiffCurvePointOutput(time_cnt,2);
    ] + CurvePointOutput(time_cnt,2);
    
    buff_y = [
        0;
        2*DiffCurvePointOutput(time_cnt,3);
    ] + CurvePointOutput(time_cnt,3);
    
    scatter( buff_x, buff_y, 'markerEdgeColor', 'None', 'MarkerFaceColor', [0.0,0.0,1.0] );
    plot( buff_x, buff_y, 'Color', [0.0,0.0,1.0] );

    % Draw curve
    t_range = linspace( 0, 1, 30 );
    scatter( x_vector, y_vector, 'MarkerEdgeColor', 'None', 'MarkerFaceColor', [0.5,0.5,0.5] );

    for section_cnt = 1:NumOfSection
        Criteria = [ 
            x_vector(section_cnt:section_cnt+(NumOfCriteria-1));
            y_vector(section_cnt:section_cnt+(NumOfCriteria-1));
        ];

        curve = zeros( length( t_range ), 2 );

        for t_cnt = 1:length( t_range )
            t = t_range(t_cnt);
            curve(t_cnt,:) = getCurvePoint( t, Criteria, CatmullRomSpline_Const );
        end
        plot( curve(:,1), curve(:,2), 'Color', [0.5,0.5,0.5] );
    end
    
    pause( SimPeriod - double( toc( currentTime ) ) );
end
toc( AllTime );