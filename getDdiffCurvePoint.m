% t         : Arc length parameter
% points    : Index of Criteria of curves [ x(4), y(4) ]
function DdiffCurvePoint = getDdiffCurvePoint( t, Criteria, CurveConstant )
    t_vector = [ 6*t^1;2*t^0;0;0 ];
    
    DdiffCurvePoint = Criteria * CurveConstant * t_vector;
end