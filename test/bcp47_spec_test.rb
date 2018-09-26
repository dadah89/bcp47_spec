# frozen_string_literal: true

require_relative 'test_helper'
require 'bcp47_spec'

SingleCov.covered!

describe BCP47 do
  it 'validates language tag' do
    assert BCP47.valid?('de-Latn-DE-1996-x-private-test')
    refute BCP47.valid?('cantbethislong')
  end

  it 'parses language tag' do
    tag = BCP47.parse('de-Latn-DE-1996-u-attr-co-phonebk-t-und-cyrl-x-private-test')

    assert_equal 'de', tag.language
    assert_equal 'Latn', tag.script
    assert_equal 'DE', tag.region
    assert_equal %w[1996], tag.variants
    assert_equal [%w[t und-cyrl], %w[u attr-co-phonebk]], tag.extensions
    assert_equal %w[private test], tag.private
  end

  it 'parses multiple variants' do
    tag = BCP47.parse('sl-Latn-IT-rozaj-nedis-1996')

    assert_equal 'sl', tag.language
    assert_equal 'Latn', tag.script
    assert_equal 'IT', tag.region
    assert_equal %w[1996 nedis rozaj], tag.variants
    assert_equal [], tag.extensions
    assert_equal [], tag.private
  end

  # https://tools.ietf.org/html/rfc6497#section-2.1 suggests empty extensions, but  BCP-47 does not seem to allow it
  it 'does not accept empty extensions' do
    refute BCP47.valid?('ja-t-i-ami')
  end

  it 'parses CLDR language tags' do
    %w[
      af-NA af agq ak am ar-AE ar-BH ar-DJ ar-DZ ar-EG ar-EH ar-ER ar-IL ar-IQ ar-JO ar-KM ar-KW ar-LB ar-LY ar-MA ar-MR ar-OM ar-PS ar-QA ar-SA ar-SD ar-SO ar-SS ar-SY ar-TD ar-TN ar-YE ar as asa ast az-Cyrl az-Latn az bas be bem bez bg bm bn-IN bn bo-IN bo br brx bs-Cyrl bs-Latn bs ca-AD ca-ES-VALENCIA ca-FR ca-IT ca ccp-IN ccp ce cgg chr ckb-IR ckb cs cu cy da-GL da dav de-AT de-BE de-CH de-IT de-LI de-LU de dje dsb dua dyo dz ebu ee-TG ee el-CY el en-001 en-150 en-AG en-AI en-AS en-AT en-AU en-BB en-BE en-BI en-BM en-BS en-BW en-BZ en-CA en-CC en-CH en-CK en-CM en-CX en-CY en-DE en-DG en-DK en-DM en-ER en-FI en-FJ en-FK en-FM en-GB en-GD en-GG en-GH en-GI en-GM en-GU en-GY en-HK en-IE en-IL en-IM en-IN en-IO en-JE en-JM en-KE en-KI en-KN en-KY en-LC en-LR en-LS en-MG en-MH en-MO en-MP en-MS en-MT en-MU en-MW en-MY en-NA en-NF en-NG en-NL en-NR en-NU en-NZ en-PG en-PH en-PK en-PN en-PR en-PW en-RW en-SB en-SC en-SD en-SE en-SG en-SH en-SI en-SL en-SS en-SX en-SZ en-TC en-TK en-TO en-TT en-TV en-TZ en-UG en-UM en-US-POSIX en-VC en-VG en-VI en-VU en-WS en-ZA en-ZM en-ZW en eo es-419 es-AR es-BO es-BR es-BZ es-CL es-CO es-CR es-CU es-DO es-EA es-EC es-GQ es-GT es-HN es-IC es-MX es-NI es-PA es-PE es-PH es-PR es-PY es-SV es-US es-UY es-VE es et eu ewo fa-AF fa ff-CM ff-GN ff-MR ff fi fil fo-DK fo fr-BE fr-BF fr-BI fr-BJ fr-BL fr-CA fr-CD fr-CF fr-CG fr-CH fr-CI fr-CM fr-DJ fr-DZ fr-GA fr-GF fr-GN fr-GP fr-GQ fr-HT fr-KM fr-LU fr-MA fr-MC fr-MF fr-MG fr-ML fr-MQ fr-MR fr-MU fr-NC fr-NE fr-PF fr-PM fr-RE fr-RW fr-SC fr-SN fr-SY fr-TD fr-TG fr-TN fr-VU fr-WF fr-YT fr fur fy ga gd gl gsw-FR gsw-LI gsw gu guz gv ha-GH ha-NE ha haw he hi hr-BA hr hsb hu hy id ig ii is it-CH it-SM it-VA it ja jgo jmc ka kab kam kde kea khq ki kk kkj kl kln km kn ko-KP ko kok ks ksb ksf ksh kw ky lag lb lg lkt ln-AO ln-CF ln-CG ln lo lrc-IQ lrc lt lu luo luy lv mas-TZ mas mer mfe mg mgh mgo mk ml mn mr ms-BN ms-SG ms mt mua my mzn naq nb-SJ nb nd nds-NL nds ne-IN ne nl-AW nl-BE nl-BQ nl-CW nl-SR nl-SX nl nmg nn nnh nus nyn om-KE om or os-RU os pa-Arab pa-Guru pa pl prg ps pt-AO pt-CH pt-CV pt-GQ pt-GW pt-LU pt-MO pt-MZ pt-PT pt-ST pt-TL pt qu-BO qu-EC qu rm rn ro-MD ro rof root ru-BY ru-KG ru-KZ ru-MD ru-UA ru rw rwk sah saq sbp sd se-FI se-SE se seh ses sg shi-Latn shi-Tfng shi si sk sl smn sn so-DJ so-ET so-KE so sq-MK sq-XK sq sr-Cyrl-BA sr-Cyrl-ME sr-Cyrl-XK sr-Cyrl sr-Latn-BA sr-Latn-ME sr-Latn-XK sr-Latn sr sv-AX sv-FI sv sw-CD sw-KE sw-UG sw ta-LK ta-MY ta-SG ta te teo-KE teo tg th ti-ER ti tk to tr-CY tr tt twq tzm ug uk ur-IN ur uz-Arab uz-Cyrl uz-Latn uz vai-Latn vai-Vaii vai vi vo vun wae wo xog yav yi yo-BJ yo yue-Hans yue-Hant yue zgh zh-Hans-HK zh-Hans-MO zh-Hans-SG zh-Hans zh-Hant-HK zh-Hant-MO zh-Hant zh zu
    ].each do |tag|
      assert BCP47.valid?(tag)
    end
  end

  it 'raises if parsing invalid language tag' do
    assert_raises(BCP47::InvalidLanguageTag) { BCP47.parse('cantbethislong') }
  end
end
