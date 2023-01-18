<?php

namespace App\Http\Controllers;

use App\Models\Indicator;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;


class IndicatorController extends Controller
{

    /**
     * Display the main view
     *
     * @return \Illuminate\Http\Response
     */
    public function main()
    {
        $items = Indicator::all()->count();     
        return view('welcome', compact('items'));
    }


    /**
     * This function get the data from the API to upload into the database
     * 
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function downloadData(Request $request) {
        if ( Indicator::all()->count() > 0 ) {
            return redirect()->route('main')->with('info', 'Ya existen registros en la base de datos, no es necesario descargar más datos.');
        }

        $request->validate([
            'username'  => 'required',
        ]);

        $token  = Http::post( env('API_URL') . '/acceso', [
            'username' => $request->username,
            'flagJson' => true,
        ]);

        $data = Http::withHeaders(['Authorization' => 'Bearer ' . $token['token']])
                    ->get(env('API_URL') . '/indicadores');

        foreach (json_decode($data) as $value) {
            if ( $value->codigoIndicador == 'UF' ) {
                Indicator::create([
                    'name'      => $value->nombreIndicador,
                    'unit'      => $value->unidadMedidaIndicador,
                    'value'     => $value->valorIndicador,
                    'date'      => $value->fechaIndicador,
                    'time'      => $value->tiempoIndicador,
                    'origin'    => $value->origenIndicador,
                ]);
            }
        }
        
        return redirect()->route('main')->with('success', 'Se han cargado los datos exitosamente');
    }



    /**
     * This function will collect the data between dates are requested
     * 
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function getData(Request $request)
    {
        $request->validate([
            'dateStart' => 'required',
            'dateEnd'   => 'required'
        ]);

        $items  = Indicator::all()->count();
        $data   = DB::table('indicators')
                            ->select('date', 'value')
                            ->whereBetween('date', [$request->dateStart, $request->dateEnd])
                            ->orderBy('date')
                            ->get();

        if ( $data->count() == 0 ) {
            return redirect()->route('main')->with('info', 'No se han encontrado resultados en su búsqueda');
        } else {
            return view('welcome', compact('data', 'items'));    
        }
    }


    /**
     * Display the main view
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $indicators = Indicator::all()->sortBy('date');
        return view('manage', compact('indicators'));
    }

    

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'name'      => 'required',
            'unit'      => 'required',
            'value'     => 'required|regex:/^\d{1,6}(\.\d{1,2})?$/',
            'date'      => 'required',
            'origin'    => 'required',
        ]);

        Indicator::create($request->all());
        
        return redirect()->route('data.index')->with('success', 'Se ha registrado el movimiento exitosamente');
    }

    /**
     * Display view to manage the data 
     *
     * @return \Illuminate\Http\Response
     */
    public function show()
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $indicator  = Indicator::find($id);
        return view('edit', compact('indicator'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'name'      => 'required',
            'unit'      => 'required',
            'value'     => 'required|regex:/^\d{1,6}(\.\d{1,2})?$/',
            'date'      => 'required',
            'origin'    => 'required',
        ]);

        Indicator::find($id)->update($request->all());
        
        return redirect()->route('data.index')->with('success', 'Se ha actualizado el movimiento exitosamente');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $indicator  = Indicator::find($id);
        $indicator->delete();

        return redirect()->route('data.index')->with('success', 'Se ha eliminado el movimiento exitosamente');
    }
}
