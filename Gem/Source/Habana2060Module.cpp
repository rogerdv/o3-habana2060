
#include <AzCore/Memory/SystemAllocator.h>
#include <AzCore/Module/Module.h>

#include "Habana2060SystemComponent.h"

#include <Habana2060/Habana2060TypeIds.h>

namespace Habana2060
{
    class Habana2060Module
        : public AZ::Module
    {
    public:
        AZ_RTTI(Habana2060Module, Habana2060ModuleTypeId, AZ::Module);
        AZ_CLASS_ALLOCATOR(Habana2060Module, AZ::SystemAllocator);

        Habana2060Module()
            : AZ::Module()
        {
            // Push results of [MyComponent]::CreateDescriptor() into m_descriptors here.
            m_descriptors.insert(m_descriptors.end(), {
                Habana2060SystemComponent::CreateDescriptor(),
            });
        }

        /**
         * Add required SystemComponents to the SystemEntity.
         */
        AZ::ComponentTypeList GetRequiredSystemComponents() const override
        {
            return AZ::ComponentTypeList{
                azrtti_typeid<Habana2060SystemComponent>(),
            };
        }
    };
}// namespace Habana2060

#if defined(O3DE_GEM_NAME)
AZ_DECLARE_MODULE_CLASS(AZ_JOIN(Gem_, O3DE_GEM_NAME), Habana2060::Habana2060Module)
#else
AZ_DECLARE_MODULE_CLASS(Gem_Habana2060, Habana2060::Habana2060Module)
#endif
