% t         : Arc length parameter
% points    : Index of Criteria of curves [ x(4), y(4) ]
function DiffCurvePoint = getDiffCurvePoint( t, Criteria, CurveConstant )
    t_vector = [ 3*t^2;2*t^1;t^0;0 ];
    
    DiffCurvePoint = Criteria * CurveConstant * t_vector;
end