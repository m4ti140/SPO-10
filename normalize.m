function out_tab = normalize(resp_tab)

    out_tab=resp_tab;
    for i=1:size(out_tab.az_E_r,1)
        if out_tab.az_E_r(i)>1
            out_tab.az_E_r(i)=1;
        end
        if out_tab.az_E_r(i)<0
            out_tab.az_E_r(i)=0;
        end
        if out_tab.az_E_phi(i)>180
            out_tab.az_E_phi(i)=out_tab.az_E_phi(i)-360;
        end
    end
    for i=1:size(out_tab.az_H_r,1)
        if out_tab.az_H_r(i)>1
            out_tab.az_H_r(i)=1;
        end
        if out_tab.az_H_r(i)<0
            out_tab.az_H_r(i)=0;
        end
        if out_tab.az_H_phi(i)>180
            out_tab.az_H_phi(i)=out_tab.az_H_phi(i)-360;
        end
    end
    for i=1:size(out_tab.el_E_r,1)
        if out_tab.el_E_r(i)>1
            out_tab.el_E_r(i)=1;
        end
        if out_tab.el_E_r(i)<0
            out_tab.el_E_r(i)=0;
        end
        if out_tab.el_E_phi(i)>180
            out_tab.el_E_phi(i)=out_tab.el_E_phi(i)-360;
        end
    end
    for i=1:size(out_tab.el_H_r,1)
        if out_tab.el_H_r(i)>1
            out_tab.el_H_r(i)=1;
        end
        if out_tab.el_H_r(i)<0
            out_tab.el_H_r(i)=0;
        end
        if out_tab.el_H_phi(i)>180
            out_tab.el_H_phi(i)=out_tab.el_H_phi(i)-360;
        end
    end
end