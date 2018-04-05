function t = getNearestCurveParameter( Point, Criteria, CurveConstant )
    % Initialize
    t = 0;
    z = 1e9;
    
    % Number of initial state
    NumOfState = 5;
    
    % Newton method iteration
    NumOfIteration = 15;
    
    % Initial state
    t_range = linspace( -0.5, 1.5, NumOfState );
    
    for state_cnt = 1:NumOfState
        buff_t = t_range(state_cnt);
        
        % Newton method
        for iteration_cnt = 1:NumOfIteration
            CurvePoint = getCurvePoint( buff_t, Criteria, CurveConstant );
            DiffCurvePoint = getDiffCurvePoint( buff_t, Criteria, CurveConstant );
            DdiffCurvePoint = getDdiffCurvePoint( buff_t, Criteria, CurveConstant );
            
            Distance = getCurvePointDistance( Point, CurvePoint );
            DiffDistance = getDiffCurvePointDistance( Point, CurvePoint, Distance, DiffCurvePoint );
            DdiffDistance = getDdiffCurvePointDistance( Point, CurvePoint, Distance, DiffCurvePoint, DiffDistance, DdiffCurvePoint );
            
            % Update parameter t
            buff_t = buff_t - ( DiffDistance / DdiffDistance );
            
            % Limit parameter t
            if( buff_t < 0.0 )
                buff_t = 0.0;
            elseif( buff_t > 1.0 )
                buff_t = 1.0;
            end
        end
        
        % Update parameter if first iteration
%         if( isempty( z ) )
%             t = buff_t;
%             z = Distance;
%         end
        
        % Update parameter
        if( Distance < z )
            t = buff_t;
            z = Distance;
        end
    end
end