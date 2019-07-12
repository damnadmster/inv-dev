json.extract! device, :id, :name, :model, :invnum, :serial, :dateprod, :proc, :ram, :place, :mark, :cancellation, :type_id, :filial_id, :iswork, :created_at, :updated_at, :repair, :avatar, :actimage, :clearact, :brand
json.url device_url(device, format: :json)
