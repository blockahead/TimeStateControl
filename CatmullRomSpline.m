
%% Search minimum distance
Point = [ 0;0 ];
Azimuth = 1.5;

% Get parameter t which minimize distance between curve and point
[ section_min, t_min ] = getNearestCurveParameter_AllSection( Point, x_vector, y_vector, NumOfSection, NumOfCriteria, CatmullRomSpline_Const );

Criteria = [ 
    x_vector(section_min:section_min+(NumOfCriteria-1));
    y_vector(section_min:section_min+(NumOfCriteria-1));
];

CurvePoint = getCurvePoint( t_min, Criteria, CatmullRomSpline_Const );
DiffCurvePoint = getDiffCurvePoint( t_min, Criteria, CatmullRomSpline_Const );
DiffCurvePoint = DiffCurvePoint / norm( DiffCurvePoint );

z_min = getCurvePointDistance( Point, CurvePoint )

direction = getDirection( Azimuth, DiffCurvePoint )

Kr = getCurvature()

%% Plotting
figure(1); hold on;

% Draw curve
t_range = linspace( 0, 1, 30 );
scatter( x_vector, y_vector );

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
    plot( curve(:,1), curve(:,2) );
end

% Draw vehicle and circle minimize distance between vehicle and curve
th = linspace( 0, ( 2 * pi ), 30 )';

Criteria = [ 
    x_vector(section_min:section_min+(NumOfCriteria-1));
    y_vector(section_min:section_min+(NumOfCriteria-1));
];
CurvePoint = getCurvePoint( t_min, Criteria, CatmullRomSpline_Const );
z_min = getCurvePointDistance( Point, CurvePoint );
circle = [ Point(1) + z_min * cos( th ), Point(2) + z_min * sin( th ) ];

scatter( Point(1), Point(2) );
plot( circle(:,1), circle(:,2) );

% Draw azimuth vector
AzimuthVector = [
    cos( Azimuth );
    sin( Azimuth );
];

buff = [ 
    Point(1), Point(2);
    Point(1)+AzimuthVector(1), Point(2)+AzimuthVector(2);
];

plot( buff(:,1), buff(:,2) );


% Draw tangent
Criteria = [ 
    x_vector(section_min:section_min+(NumOfCriteria-1));
    y_vector(section_min:section_min+(NumOfCriteria-1));
];

tangent = getDiffCurvePoint( t_min, Criteria, CatmullRomSpline_Const )';
tangent = tangent / norm( tangent );
curvePoint = getCurvePoint( t_min, Criteria, CatmullRomSpline_Const );
buff = [ 
    curvePoint(1), curvePoint(2);
    curvePoint(1)+tangent(1), curvePoint(2)+tangent(2);
];

plot( buff(:,1), buff(:,2) );

axis equal;

