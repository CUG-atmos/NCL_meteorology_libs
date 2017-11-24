begin

  ;;;;read SLP data   
  f     = addfile("./data/mslp.mon.mean.r2.nc", "r")  
  slp = short2flt(f->mslp(::12,{0:90},:))  ;��ȡÿ���1�£�����������
  
  dims = dimsizes(slp)                    ; ���ظ�ά�Ĵ�С

  year = ispan(1979,1979+dims(0)-1,1)     ; �����ĸ����
  
  ;; ����Ȩ��  
  w  = sqrt(cos(0.01745329*slp&lat) )     ; Ȩ��ϵ��                 
  wp = slp*conform(slp, w, 1)             ; wp
  copy_VarCoords(slp, wp)
  
  ;; EOF�ֽ�
  x    = wp({lat|20:90},lon|:,time|:)  ; ʱ��ά�����ұ�
  neof = 2                             ; ����ǰ2ģ̬�����ڼ����1ģ̬�Ƿ�����������ģ̬�����
  eof  = eofunc_Wrap(x, neof, False)   ; EOF�ֽ�

  ;; north ����
  ntim = dims(0)               
  sig_pcv = eofunc_north(eof@pcvar, ntim, False)
    
  ;; ����PC������׼��
  eof_ts = eofunc_ts_Wrap (x, eof, False)
  eof_ts = dim_standardize_n(eof_ts,1,1)

  ;; �����netcdf�ļ�

  ;; �ع�SLP�� 

  ;; t-test
   ; �����µı���
       ; ת��Ϊ hPa
  
     
  
  
  
  ; ���´�����Ŀ���Ƿ����ͼ�����Ǳ��룩
  confi_rc_slp = where(confi_rc_slp.eq.0,confi_rc_slp@_FillValue,confi_rc_slp)  
  confi_rc_slp = 1/confi_rc_slp
  confi_rc_slp = where(rc_slp.lt.0,-1*confi_rc_slp,confi_rc_slp)
  
  ;;;;;;;;;plot;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
  wks = gsn_open_wks("eps","plot-reg-SLP")
  gsn_define_colormap(wks,"rainbow")  
         
  res                   = True    
  
  res@gsnDraw           = False         
  res@gsnFrame          = False        
  res@gsnLeftString     = ""
  res@gsnRightString    = ""  

  res@gsnTickMarksOn = False ; �رվ��ȱ�ǩ����ȻĬ���ǻ��ƾ��ȱ�ǩ���������侭�ȵ�λǰû�С��ȡ����ţ�����o������������ر����侭�ȱ�ǩ��������Ʊ�׼�ľ��ȱ�ǩ�������ú���gsn_add_text�������¼A.5�ڣ��Լ��ı��������š�~������¼ͼA.5�������ֶ����ӡ�
  
  resc = res          ;���Ƹ�resc,���Ի��ƻع鳡�ĵ�ֵ��          
    
          ;������ļ������ͶӰ    
  
  res@mpFillOn        = False       
           ; ��ͼ������γ��
  res@mpMaxLatF       = 90          ; �γ��
           ; ���ľ���
  
  res@cnLevelSelectionMode  = "ExplicitLevels"
  res@cnLevels              = (/-20,20/) ; -20��20����Ӧ��0.05���Ŷȣ���ǰ�߶�Ӧ��ֵ�쳣�����߶�Ӧ��ֵ�쳣
  res@cnFillColors          = (/"gray","white","gray"/)
  res@cnFillOn              = True 
  res@lbLabelBarOn          = False   ; ���ڻ��Ƶ��������ԣ�ֻ�м���ֵ����һ�㲻��Ҫ�������¼���           
  res@cnLinesOn             = False   ;  
  res@cnInfoLabelOn         = False   ; 
  res@cnLineLabelsOn        = False   ; 
   
 

  ;; �ع鳡��ֵ�ߵ�����
  resc@cnLevelSelectionMode  = "ExplicitLevels"
  resc@cnLevels              =  1.*ispan(-10,10,1)    
  resc@cnFillOn              = False    
  resc@cnInfoLabelOn         = False
  resc@gsnContourZeroLineThicknessF = 0.
  resc@cnLineThicknessF             = 2.
  resc@cnLineLabelsOn               = False
  plot = gsn_csm_contour(wks,rc_slp,resc) 
  plot = ColorNegDashZeroPosContour(plot,"black","black","black")
  
   ; ͼ�����

  ;; ���Ӹ���ĵ�ֵ��
  resc2 = resc
  resc2@cnLevels           := (/-4,2/)  
  resc2@cnLineThicknessF   = 7.  
  resc2@cnMonoLineDashPattern = False
  resc2@cnLineDashPatterns    = (/1,0/) ; �������ò�ͬ�����ͣ� Ҳ��ͨ��ColorNegDashZeroPosContourʵ��
  resc2@cnLineDashSegLenF     = 0.25    ; ������ÿ���߶εĳ��ȣ����Զ�������֮��ļ��
  plot2 = gsn_csm_contour(wks,rc_slp,resc2) 
   
  overlay(base,plot2)
  
  draw(base)
  frame(wks)

end