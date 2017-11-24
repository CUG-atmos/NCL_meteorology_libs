begin
  name = (/"Beijing","Shanghai","Lijiang","Wulumuqi"/)  
  irec = (/33,56,115,160/) -1 ; ��Ӧ�������Ϻ�����������³ľ���ĸ�վ��160վ��λ�ã�����ɲ鿴station-name.txt

  ntime = 30   ; ��30��ʱ��
  nstat = 160  ; ��160վ
    
  ;��ȡȫ�����ݣ�ע�����ݴ�ŵ�·���������д����./data ��

  
  ;�ֶ�����meta data
  preci!0="year" 
  preci!1="station"
  preci&year = ispan(1979,2008,1)
  preci&station = ispan(1,160,1)
  
  ; �������ĸ�վ������

   
;***************************************************** 
; create plot
;***************************************************** 
  wks = gsn_open_wks("eps","plot-preci-4stations")  ;����epsͼ            
 
  res           = True              

  res@vpHeightF = 0.35  ; �ı�viewport�Ĵ�С
  res@vpWidthF 	= 0.6   ; 

  res@trXMinF	  = 1979  ; �趨X�����귶Χ
  res@trXMaxF	  = 2008
  res@trYMaxF   = 1400   ; �趨Y�����귶Χ
  res@trYMinF   = 0 

                ; ��xy linesʹ�ö�����ɫ
  res@xyLineThicknesses	= (/3., 1.,1.,1./)      ; �趨��ͬ�Ĵ�ϸ��3Ϊ3���֣�4��ֵ��Ӧ4��վ
  res@xyDashPattern	    = 0                     ; �趨ȫ��xy lineΪʵ��
  res@xyMarkLineModes   = (/"MarkLines","MarkLines","MarkLines","MarkLines"/) ; �趨xy line ������,������ǡ�Markers������Ϊɢ��ͼ��
  res@xyMarkers         = (/9,7,5,3/)   ; �趨xy line��marker ������
  res@xyMarkerSizeF     = 0.01          ; �趨xy line��marker�Ĵ�С
  res@xyLineColors      = (/"black","red","blue","brown"/)  ; �趨xy line����ɫ

  res@tiXAxisString	= "year"             ; ����X������   
  res@tiYAxisString	= "precipitation (units: mm)"    ; ����Y������ 
   
  res@pmLegendDisplayMode    = "Always"  ; ��ͼ�� 
  res@pmLegendSide           =  "top"    ; �ı�ͼ����λ�ã�Ĭ��"bottom" 
  res@pmLegendParallelPosF   = 0.18      ; ��ֵ�����ƶ�
  res@pmLegendOrthogonalPosF = -0.32     ; ��ֵ�����ƶ�
  res@pmLegendWidthF         = 0.2       ; �ı�ͼ���ĳ�����߶�
  res@pmLegendHeightF        = 0.1       ;   
  
        ; �ı�ͼ����ǩ����Ĵ�С
        ; ͼ���ϲ�Ҫ���Ʊ߿�

        ; ָ��ͼ����ǩ����������

        ; ���ƴ�ֱ��X��Ĳο���
        ; ������
        ; ����ϸ
  
        ; ���ƴ�ֱ��Y��Ĳο���
        ; ������
        ; ����ϸ

  top_plot = gsn_csm_xy(wks,preci_st&year,preci_st(station|:,year|:),res)       ; ��ͼ
  
end