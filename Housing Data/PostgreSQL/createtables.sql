CREATE TABLE IF NOT EXISTS public.data
(
    "UniqueID" integer NOT NULL,
    "ParcelID" numeric(20) NOT NULL,
    "LandUse" character varying(20),
    "PropertyAddress" character varying(50),
    "SaleDate" date,
    "LegalReference" character varying(50),
    "SoldAsVacant" boolean,
    "OwnerName" character varying(50),
    "OwnerAddress" character varying(50),
    "Acreage" numeric(10),
    "TaxDistrict" character varying,
    "LandValue" integer,
    "BuildingValue" integer,
    "TotalValue" integer,
    "YearBuilt" integer,
    "Bedrooms" integer,
    "FullBath" integer,
    "HalfBath" integer
)

TABLESPACE pg_default;

ALTER TABLE public.data
    OWNER to postgres;
