SELECT  
e.EventName
,e.EventDate
,case when e.EventName like 'MS%' then 'MU BBall' when e.PrimaryPerformer = '<Unknown>' then e.NBATeamFullName else e.PrimaryPerformer end as 'EventAct'
,t.PriceCode
,t.PlanName
,a.ArchticsAccountId
,case when a.ArchticsAccountId IN (902553503, 90101071, 90101253, 101848, 12758573, 7665877, 114223, 904356170, 11972455, 191454, 1996271, 904402875, 5725197, 12501396, 11135087, 90100149, 12758805, 90103853, 12628859, 1073325, 233595, 12268862, 103245, 279497, 3390147, 4941758, 5160515, 7342501, 90101352, 904402883, 1996513, 4245650, 120625) then 'Loft Holder' else 'Non-Holder' end as 'Loft Holder'
,a.CompanyName
,concat(a.CustomerNameFirst,' ',a.CustomerNameLast) as 'Customer Name'
,t.RepFullName
,t.SectionName
,t.RowName
,t.SeatName
,case when t.PriceCode like '_P11' or t.PriceCode like '_P12' then 'Duplicate' else 'Count' end as 'Rev Duplicate?'
,case when t.InventoryNetAmount <0 then 0 else t.InventoryNetAmount end as 'InventoryNetAmount'
,case 
  when e.EventName like 'CNRT' then 'CNRT Package'
  when t.RowName like 'Loge T%' then concat(right(t.SectionName,3),'LT', right(t.RowName,1))
  when t.RowName = 'Row SRO' and t.SectionName like 'Suite%' then 'Suite SRO'
  else t.SectionName end as 'Space'



FROM [host].[TicketSales] t
    left join archtics.accountprimarycustomer a on t.AccountKey = a.AccountKey
    left join archtics.Events e on t.SeasonKey = e.SeasonKey and t.Eventkey = e.EventKey
  WHERE e.SeasonKey = 2019 and (e.EventName like 'S%' or e.EventName like 'L1%' or e.EventName like 'L2%' or e.eventname like 'MS%' or e.EventName like 'CNRT%') and t.InventoryStatusName = 'Sold'
  

-- Above (host) pulls MU and Sp Event results, Below (TicketSales) pulls Bucks
UNION

  SELECT  
e.EventName
,e.EventDate
,case when e.EventName like 'MS%' then 'MU BBall' when e.PrimaryPerformer = '<Unknown>' then e.NBATeamFullName else e.PrimaryPerformer end as 'EventAct'
,t.PriceCode
,t.PlanName
,a.ArchticsAccountId
,case when a.ArchticsAccountId IN (902553503, 90101071, 90101253, 101848, 12758573, 7665877, 114223, 904356170, 11972455, 191454, 1996271, 904402875, 5725197, 12501396, 11135087, 90100149, 12758805, 90103853, 12628859, 1073325, 233595, 12268862, 103245, 279497, 3390147, 4941758, 5160515, 7342501, 90101352, 904402883, 1996513, 4245650, 120625) then 'Loft Holder' else 'Non-Holder' end as 'Loft Holder'
,a.CompanyName
,concat(a.CustomerNameFirst,' ',a.CustomerNameLast) as 'Customer Name'
,t.RepFullName
,t.SectionName
,t.RowName
,t.SeatName
,case when t.PriceCode like '_P11' or t.PriceCode like '_P12' then 'Duplicate' else 'Count' end as 'Rev Duplicate?'
,case when t.InventoryNetAmount <0 then 0 else t.InventoryNetAmount end as 'InventoryNetAmount'
,case 
  when e.EventName like 'CNRT' then 'CNRT Package'
  when t.RowName like 'Loge T%' then concat(right(t.SectionName,3),'LT', right(t.RowName,1))
  when t.RowName = 'Row SRO' and t.SectionName like 'Suite%' then 'Suite SRO'
  else t.SectionName end as 'Space'


FROM [archtics].[TicketSales] t
    left join archtics.accountprimarycustomer a on t.AccountKey = a.AccountKey
    left join archtics.Events e on t.SeasonKey = e.SeasonKey and t.Eventkey = e.EventKey
  WHERE e.SeasonKey = 2019 and (e.EventName like 'BS%' or (e.EventName like 'BA%' and t.SectionName like 'North%') or (e.EventName like 'MB%' and t.SectionName = 'Pano Deck')) and t.InventoryStatusName = 'Sold'
  order by e.EventName, SectionName