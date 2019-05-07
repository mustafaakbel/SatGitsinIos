//
//  Ilan.swift
//  SatGitsin
//
//  Created by Mustafa AKBEL on 5.05.2019.
//  Copyright © 2019 Mustafa AKBEL. All rights reserved.
//

class Ilan{
    var ilanId:String?
    var uid:String?
    var baslik:String?
    var ozellik:String?
    var fiyat:String?
    var satilma_durumu:String?
    var kategori:String?
    var ilk_urun_foto:String?
    var urun_foto_adet:String?
    
    init(ilanId:String?,uid:String?,baslik:String?,ozellik:String?,fiyat:String?,satilma_durumu:String?,kategori:String?,ilk_urun_foto:String?,urun_foto_adet:String?) {
        self.ilanId = ilanId
        self.uid = uid
        self.baslik = baslik
        self.ozellik = ozellik
        self.fiyat = fiyat
        self.satilma_durumu = satilma_durumu
        self.kategori = kategori
        self.ilk_urun_foto = ilk_urun_foto
        self.urun_foto_adet = urun_foto_adet
    }
}
