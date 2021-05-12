class Operations::Onboards::EntityMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "kind_pretty" => ::Operations::Onboards::EntityRepository::ENUM_KIND[model.kind] })
    obj = obj.merge({ "master_name_pretty" => ::Operations::Onboards::EntityRepository::ENUM_MASTER_NAME[chart.master_name] })
    obj = obj.merge({ "group_pretty" => ::Operations::Onboards::EntityRepository::ENUM_GROUP[chart.group] })
    obj = obj.merge({ "master_group_pretty" => ::Operations::Onboards::EntityRepository::ENUM_MASTER_GROUP[chart.master_group] })
    obj = obj.merge({ "master_pretty" => ::Operations::Onboards::EntityRepository::ENUM_MASTER[chart.master] })

    obj = obj.merge({ "product_name_pretty" => ::Operations::Onboards::EntityRepository::ENUM_PRODUCT_NAME[model.product_name] })
    obj = obj.merge({ "product_kind_pretty" => ::Operations::Onboards::EntityRepository::ENUM_PRODUCT_KIND[model.product_kind] })
    obj = obj.merge({ "product_service_pretty" => ::Operations::Onboards::EntityRepository::ENUM_PRODUCT_SERVICE[model.product_service] })
    obj = obj.merge({ "kind_pretty" => ::Operations::Onboards::EntityRepository::ENUM_KIND[model.kind] })
    obj = obj.merge({ "status_pretty" => ::Operations::Onboards::EntityRepository::ENUM_STATUS[model.status] })
    # obj = obj.merge({ "journey_status_pretty" => ::Operations::Onboards::JourneyRepository::ENUM_STAGE[model.journey_status] })
    # obj = obj.merge({ "parties" => ::Operations::Onboards::PartyRepository.list(model.parties) })

    return obj
  end

end