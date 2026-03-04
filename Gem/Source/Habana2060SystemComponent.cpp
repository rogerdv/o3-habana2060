
#include <AzCore/Serialization/SerializeContext.h>

#include "Habana2060SystemComponent.h"

#include <Habana2060/Habana2060TypeIds.h>

namespace Habana2060
{
    AZ_COMPONENT_IMPL(Habana2060SystemComponent, "Habana2060SystemComponent",
        Habana2060SystemComponentTypeId);

    void Habana2060SystemComponent::Reflect(AZ::ReflectContext* context)
    {
        if (auto serializeContext = azrtti_cast<AZ::SerializeContext*>(context))
        {
            serializeContext->Class<Habana2060SystemComponent, AZ::Component>()
                ->Version(0)
                ;
        }
    }

    void Habana2060SystemComponent::GetProvidedServices(AZ::ComponentDescriptor::DependencyArrayType& provided)
    {
        provided.push_back(AZ_CRC_CE("Habana2060Service"));
    }

    void Habana2060SystemComponent::GetIncompatibleServices(AZ::ComponentDescriptor::DependencyArrayType& incompatible)
    {
        incompatible.push_back(AZ_CRC_CE("Habana2060Service"));
    }

    void Habana2060SystemComponent::GetRequiredServices([[maybe_unused]] AZ::ComponentDescriptor::DependencyArrayType& required)
    {
    }

    void Habana2060SystemComponent::GetDependentServices([[maybe_unused]] AZ::ComponentDescriptor::DependencyArrayType& dependent)
    {
    }

    Habana2060SystemComponent::Habana2060SystemComponent()
    {
        if (Habana2060Interface::Get() == nullptr)
        {
            Habana2060Interface::Register(this);
        }
    }

    Habana2060SystemComponent::~Habana2060SystemComponent()
    {
        if (Habana2060Interface::Get() == this)
        {
            Habana2060Interface::Unregister(this);
        }
    }

    void Habana2060SystemComponent::Init()
    {
    }

    void Habana2060SystemComponent::Activate()
    {
        Habana2060RequestBus::Handler::BusConnect();
    }

    void Habana2060SystemComponent::Deactivate()
    {
        Habana2060RequestBus::Handler::BusDisconnect();
    }
}
