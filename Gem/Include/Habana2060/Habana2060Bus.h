
#pragma once

#include <Habana2060/Habana2060TypeIds.h>

#include <AzCore/EBus/EBus.h>
#include <AzCore/Interface/Interface.h>

namespace Habana2060
{
    class Habana2060Requests
    {
    public:
        AZ_RTTI(Habana2060Requests, Habana2060RequestsTypeId);
        virtual ~Habana2060Requests() = default;
        // Put your public methods here
    };

    class Habana2060BusTraits
        : public AZ::EBusTraits
    {
    public:
        //////////////////////////////////////////////////////////////////////////
        // EBusTraits overrides
        static constexpr AZ::EBusHandlerPolicy HandlerPolicy = AZ::EBusHandlerPolicy::Single;
        static constexpr AZ::EBusAddressPolicy AddressPolicy = AZ::EBusAddressPolicy::Single;
        //////////////////////////////////////////////////////////////////////////
    };

    using Habana2060RequestBus = AZ::EBus<Habana2060Requests, Habana2060BusTraits>;
    using Habana2060Interface = AZ::Interface<Habana2060Requests>;

} // namespace Habana2060
