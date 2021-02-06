module Users
  module Companies
    class EntityMapper < BaseMapper

      def self.map model
        obj = model.attributes
        
        obj = obj.merge({ "cnpj_pretty" => model.cnpj_pretty })
        obj = obj.merge({ "subkind_pretty" => ::Users::Companies::EntityRepository::ENUM_SUBKIND[model.subkind.first] })
        obj = obj.merge({ "class_type" => ::App::ClassName::FromSchema::TRANSLATE[model.class.name] })

        return obj
      end

      def map_collection model_collection
        model_collection.map{ |model| map(model) }
      end
      
      def map_all_active model_collection
        model_collection.where(active: true).map{ |model| map(model) }
      end

      def self.map_report entity, kind
        data = {}
        data = data.merge({"company_total" => entity.where(active: true).where("? = ANY (kind)", kind).count})
        data = data.merge({"company_kind" => ::Users::Companies::HumanizeCompanyKind::NAME[kind]})
        data = data.merge({"company_url" => ::Users::Companies::HumanizeCompanyKind::URL[kind]})
      end

      def self.report_with_permissions entity, current_user, feature
        collection = map_report(entity, feature)
        permissions = {"current_user_permissions" => ::Users::PermissionRepository.find_by_feature_name(current_user, feature)}
        {:collection => collection, :permissions => permissions}
      end

      def self.map_all_with_permissions model_collection, current_user, feature
        collection = model_collection.map{ |model| map(model) }
        permissions = {"current_user_permissions" => ::Users::PermissionRepository.find_by_feature_name(current_user, feature)}
        {:collection => collection, :permissions => permissions}
      end

      def self.map_with_permissions model, current_user, feature
        collection = map model
        permissions = {"current_user_permissions" => ::Users::PermissionRepository.find_by_feature_name(current_user, feature)}
        {:collection => collection, :permissions => permissions}
      end

    end
  end
end