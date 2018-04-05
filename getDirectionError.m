function direction = getDirectionError( Azimuth, t, Criteria, CurveConstant )
    AzimuthVector = [
        cos( Azimuth );
        sin( Azimuth );
    ];

    CurveTangentVector = getDiffCurvePoint( t, Criteria, CurveConstant );
    CurveTangentVector = CurveTangentVector / norm( CurveTangentVector );

    direction = asin( AzimuthVector(1) * CurveTangentVector(2) - AzimuthVector(2) * CurveTangentVector(1) );
end