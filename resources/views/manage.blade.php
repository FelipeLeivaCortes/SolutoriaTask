<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Laravel</title>

        <!-- Styles -->
        <link href="{{ asset('css/app.css') }}" rel="stylesheet">
        <link href="{{ asset('css/custom.css') }}" rel="stylesheet">
        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.2.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.1/css/dataTables.bootstrap5.min.css">



        <!-- Scripts -->
        <script src="{{ asset('js/app.js') }}" defer></script>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.1/js/dataTables.bootstrap5.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        
        <script src="{{ asset('js/custom.js') }}"></script>
    </head>

    <body class="antialiased">

        <!-- Required to show events in a modal -->
        @include('alerts')



        <div class="container" id="root">
            <!-- Title -->
            <section class="mt-5">
                <h2 class="d-flex justify-content-center">
                    Administración de Datos
                </h2>

                <p class="mt-5">En esta sección podrás administrar los datos registrados.</p>
            </section>

            <section class="my-5">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">
                            <h4>Registros de la UF</h4>

                            <a href="{{route('data.create')}}" class="btn btn-primary">Agregar</a>
                        </div>
                    </div>

                    <div class="card-body">
                        <table class="table table-striped myTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Unidad</th>
                                    <th>Valor</th>
                                    <th>Fecha</th>
                                    <th>Tiempo</th>
                                    <th>Origen</th>
                                    <th>Acción</th>
                                    <td>&nbsp;</td>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach ($indicators as $indicator)
                                    <tr>
                                        <td>{{$indicator->id}}</td>
                                        <td>{{$indicator->name}}</td>
                                        <td>{{$indicator->unit}}</td>
                                        <td>{{$indicator->value}}</td>
                                        <td>{{date('d/m/Y', strtotime($indicator->date))}}</td>
                                        <td>{{ isset($indicator->time) ? $indicator->time : '-' }}</td>
                                        <td>{{$indicator->origin}}</td>
                                        <td width="10px">
                                            <a href="{{route('data.edit', $indicator)}}" class="btn btn-info btn-sm">Editar</a>
                                        </td>
                                        <td width="10px">
                                            {!! Form::open(['route' => ['data.destroy', $indicator], 'class' => 'delete']) !!}
                                                @method('delete')
                                                {!! Form::submit('Eliminar', ['class' => 'btn btn-danger btn-sm']) !!}
                                            {!! Form::close() !!}
                                        </td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>

                    <div class="card-footer">
                        <a href="{{route('main')}}" class="btn btn-danger">Volver</a>
                    </div>
                </div>
            </section>
        </div>
    </body>
</html>
