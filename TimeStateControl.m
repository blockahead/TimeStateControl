function delta = TimeStateControl( Point, Azimuth, dsdt, x_vector, y_vector, l, NumOfSection, NumOfCriteria, CurveConstant )
    % Get parameter t which minimize distance between curve and point
    [ section_min, t_min ] = getNearestCurveParameter_AllSection( Point, x_vector, y_vector, NumOfSection, NumOfCriteria, CurveConstant );
    
    Criteria = [ 
        x_vector(section_min:section_min+(NumOfCriteria-1));
        y_vector(section_min:section_min+(NumOfCriteria-1));
    ];

    th_diff = getDirectionError( Azimuth, t_min, Criteria, CurveConstant );

    z = getDistanceError( Point, t_min, Criteria, CurveConstant );
    
    dzds = -sin( th_diff );
    
    state = [ z;dzds ];
    
    if( dsdt >= 0 )
        F_StateFeedback = [ 4.0, 4.0 ];
    else
        F_StateFeedback = [ 4.0, -4.0 ];
    end
    
    mu = - F_StateFeedback * state;
    
    Kr = getCurvature( t_min, Criteria, CurveConstant );
    
    delta = InputConversion( mu, z, th_diff, Kr, l );
end