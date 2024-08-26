tDF = {}

tDF.create_button = function(name,
  parent_frame,
  anchor,
  w,
  h,
  normal_tx,
  pushed_tx,
  highlight_tx,
  normal_txc,
  pushed_txc,
  highlight_txc,
  offset_x,
  offset_y,
  f_OnEnter,
  f_OnLeave,
  f_OnClick)
  local frame = CreateFrame("Button", name, parent_frame, "UIPanelButtonTemplate")
  frame:SetWidth(w)
  frame:SetHeight(h)
  frame:SetPoint(anchor, parent_frame, offset_x, offset_y)
  frame:SetNormalTexture(normal_tx)
  frame:SetPushedTexture(pushed_tx)
  frame:SetHighlightTexture(highlight_tx)
  local NormalTexture = frame:GetNormalTexture()
  local PushedTexture = frame:GetPushedTexture()
  local HighlightTexture = frame:GetHighlightTexture()
  NormalTexture:SetTexCoord(normal_txc[1], normal_txc[2], normal_txc[3], normal_txc[4])
  PushedTexture:SetTexCoord(pushed_txc[1], pushed_txc[2], pushed_txc[3], pushed_txc[4])
  HighlightTexture:SetTexCoord(highlight_txc[1], highlight_txc[2], highlight_txc[3], highlight_txc[4])
  frame:SetScript("OnEnter", f_OnEnter)
  frame:SetScript("OnLeave", f_OnLeave)
  frame:SetScript("OnClick", f_OnClick)
  return frame
end