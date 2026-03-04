
#pragma once

#include <AzCore/Component/Component.h>

#include <Habana2060/Habana2060Bus.h>

namespace Habana2060
{
    class Habana2060SystemComponent
        : public AZ::Component
        , protected Habana2060RequestBus::Handler
    {
    public:
        AZ_COMPONENT_DECL(Habana2060SystemComponent);

        static void Reflect(AZ::ReflectContext* context);

        static void GetProvidedServices(AZ::ComponentDescriptor::DependencyArrayType& provided);
        static void GetIncompatibleServices(AZ::ComponentDescriptor::DependencyArrayType& incompatible);
        static void GetRequiredServices(AZ::ComponentDescriptor::DependencyArrayType& required);
        static void GetDependentServices(AZ::ComponentDescriptor::DependencyArrayType& dependent);

        Habana2060SystemComponent();
        ~Habana2060SystemComponent();

    protected:
        ////////////////////////////////////////////////////////////////////////
        // Habana2060RequestBus interface implementation

        ////////////////////////////////////////////////////////////////////////

        ////////////////////////////////////////////////////////////////////////
        // AZ::Component interface implementation
        void Init() override;
        void Activate() override;
        void Deactivate() override;
        ////////////////////////////////////////////////////////////////////////
    };
}
